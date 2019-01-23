unit HsFunctionsEx;

interface

Type
  PtrInt = Integer;

Function StrLenPas(S: pointer) : PtrInt;

Function PadL(Const AString : String; Const ALen : Integer; Const AChar : Char = ' ') : String;
Function PushZero(Const AString : String; Const ALen : Integer) : String;
Function PushZeroR(Const AString : String; Const ALen : Integer) : String;
Function UnPushZeroR(Const AString : String) : String;
Function MessageConfirm(Const AMessage : String) : Boolean;
Procedure AppLogFile(Const AMessage : String; AFileName : String = ''; AWriteDate : Boolean = True);

Var
  MoveFast : Procedure(Const Source; Var Dest; Count: PtrInt);
  FillcharFast : Procedure(Var Dest; count: PtrInt; Value: Byte);
  StrLen : Function(S: pointer): PtrInt = StrLenPas;

implementation

Uses
  Classes, SysUtils, Controls, Dialogs;

Var
  /// the available CPU features, as recognized at program startup
  CpuFeatures: set of
   ( { in EDX }
   cfFPU, cfVME, cfDE, cfPSE, cfTSC, cfMSR, cfPAE, cfMCE,
   cfCX8, cfAPIC, cf_d10, cfSEP, cfMTRR, cfPGE, cfMCA, cfCMOV,
   cfPAT, cfPSE36, cfPSN, cfCLFSH, cf_d20, cfDS, cfACPI, cfMMX,
   cfFXSR, cfSSE, cfSSE2, cfSS, cfHT, cfTM, cfIA_64, cfPBE,
   { in ECX }
   cfSSE3, cf_c1, cf_c2, cfMON, cfDS_CPL, cf_c5, cf_c6, cfEIST,
   cfTM2, cfSSSE3, cfCID, cfSSE5, cf_c12, cfCX16, cfxTPR, cf_c15,
   cf_c16, cf_c17, cf_c18, cfSSE41, cfSSE42, cf_c21, cf_c22, cfPOPCNT,
   cf_c24, cfAESNI, cf_c26, cf_c27, cfAVX, cf_c29, cf_c30, cf_HYP);

type
  TRegisters = record
    eax,ebx,ecx,edx: cardinal;
  end;

procedure GetCPUID(Param: Cardinal; var Registers: TRegisters);
asm
  push esi
  push edi
  mov esi,edx
  mov edi,eax
  pushfd
  pop eax
  mov edx,eax
  xor eax,$200000
  push eax
  popfd
  pushfd
  pop eax
  xor eax,edx
  jz @nocpuid
  push ebx
  mov eax,edi
  cpuid
  mov TRegisters(esi).&eax,eax
  mov TRegisters(esi).&ebx,ebx
  mov TRegisters(esi).&ecx,ecx
  mov TRegisters(esi).&edx,edx
  pop ebx
@nocpuid:
  pop edi
  pop esi
end;

procedure TestIntelCpuFeatures;
var regs: TRegisters;
begin
  regs.edx := 0;
  regs.ecx := 0;
  GetCPUID(1,regs);
  PIntegerArray(@CpuFeatures)^[0] := regs.edx;
  PIntegerArray(@CpuFeatures)^[1] := regs.ecx;
end;
   
Function StrLenPas(S: pointer): PtrInt;
Asm // slower than x86/SSE* StrLen(), but won't read any byte beyond the string
  TEST EAX,EAX
  MOV EDX,EAX
  JZ @0
  XOR EAX,EAX
  @s: CMP byte ptr [EAX+EDX+0],0; JE @0
  CMP byte ptr [EAX+EDX+1],0; JE @1
  CMP byte ptr [EAX+EDX+2],0; JE @2
  CMP byte ptr [EAX+EDX+3],0; JE @3
  ADD EAX,4
  JMP @s
  @1: INC EAX
  @0: RET
  @2: ADD EAX,2; RET
  @3: ADD EAX,3
End;

Function StrLenX86(S: pointer): PtrInt;
// pure x86 function (if SSE2 not available) - faster than SysUtils' version
Asm
  TEST EAX,EAX
  JZ @@z
  CMP   byte ptr [EAX+0],0; JE @@0
  CMP   byte ptr [EAX+1],0; JE @@1
  CMP   byte ptr [EAX+2],0; JE @@2
  CMP   byte ptr [EAX+3],0; JE @@3
  PUSH  EAX
  AND   EAX,-4              { DWORD Align Reads }
  @@Loop:
  ADD   EAX,4
  MOV   EDX,[EAX]           { 4 Chars per Loop }
  LEA   ECX,[EDX-$01010101]
  NOT   EDX
  AND   EDX,ECX
  AND   EDX,$80808080       { Set Byte to $80 at each #0 Position }
  JZ    @@Loop              { Loop until any #0 Found }
  @@SetResult:
  POP   ECX
  BSF   EDX,EDX             { Find First #0 Position }
  SHR   EDX,3               { Byte Offset of First #0 }
  ADD   EAX,EDX             { Address of First #0 }
  SUB   EAX,ECX             { Returns Length }
  @@z: RET
  @@0: XOR EAX,EAX; RET
  @@1: MOV EAX,1;   RET
  @@2: MOV EAX,2;   RET
  @@3: MOV EAX,3
End;

Procedure MoveX87;
Asm // eax=source edx=dest ecx=count
         // original code by John O'Harrow - included since delphi 2007
  CMP     EAX,EDX
  JZ      @exit                 // exit if source=dest
  cmp     ECX,32
  JA      @lrg                  // count > 32 or count < 0
  sub     ECX,8
  JG      @sml                  // 9..32 byte move
  jmp     dword ptr [@table+32+ECX*4]   // 0..8 byte move
  @sml:   FILD    qword ptr [EAX+ECX]   // load last 8
  FILD    qword ptr [EAX]       // load first 8
  CMP     ECX,8
  JLE     @sml16
  FILD    qword ptr [EAX+8]     // load second 8
  CMP     ECX,16
  JLE     @sml24
  FILD    qword ptr [EAX+16]    // load third 8
  FISTP   qword ptr [EDX+16]    // save third 8
  @sml24: FISTP   qword ptr [EDX+8]     // save second 8
  @sml16: FISTP   qword ptr [EDX]       // save first 8
  FISTP   qword ptr [EDX+ECX]   // save last 8
  @exit:  RET
  LEA EAX,[EAX+0]  // for 4-byte alignment of @table
  @table: DD @exit,@m01,@m02,@m03,@m04,@m05,@m06,@m07,@m08
  @lrgfwd:PUSH    EDX
  FILD    qword ptr [EAX]       // first 8
  LEA     EAX,[EAX+ECX-8]
  LEA     ECX,[ECX+EDX-8]
  FILD    qword ptr [EAX]       // last 8
  PUSH    ECX
  NEG     ECX
  AND     EDX,-8                // 8-byte align writes
  LEA     ECX,[ECX+EDX+8]
  POP     EDX
  @fwd:   FILD    qword ptr [EAX+ECX]
  FISTP   qword ptr [EDX+ECX]
  ADD     ECX,8
  JL      @fwd
  FISTP   qword ptr [EDX]       // last 8
  POP     EDX
  FISTP   qword ptr [EDX]       // first 8
  RET
  @lrg:   JNG     @done                 // count < 0
  cmp     EAX,EDX
  JA      @lrgfwd
  SUB     EDX,ECX
  CMP     EAX,EDX
  LEA     EDX,[EDX+ECX]
  JNA     @lrgfwd
  SUB     ECX,8                 // backward move
  push    ECX
  FILD    qword ptr [EAX+ECX]   // last 8
  FILD    qword ptr [EAX]       // first 8
  ADD     ECX,EDX
  AND     ECX,-8                // 8-byte align writes
  SUB     ECX,EDX
  @bwd:   FILD    qword ptr [EAX+ECX]
  FISTP   qword ptr [EDX+ECX]
  SUB     ECX,8
  JG      @bwd
  POP     ECX
  FISTP   qword ptr [EDX]       // first 8
  FISTP   qword ptr [EDX+ECX]   // last 8
  @done:  RET
  @m01:   MOVZX   ECX,byte ptr [EAX]
  MOV     [EDX],CL
  RET
  @m02:   MOVZX   ECX,word ptr [EAX]
  MOV     [EDX],CX
  RET
  @m03:   MOV     CX,[EAX]
  MOV     AL,[EAX+2]
  MOV     [EDX],CX
  MOV     [EDX+2],AL
  RET
  @m04:   MOV     ECX,[EAX]
  MOV     [EDX],ECX
  RET
  @m05:   MOV     ECX,[EAX]
  MOV     AL,[EAX+4]
  MOV     [EDX],ECX
  MOV     [EDX+4],AL
  RET
  @m06:   MOV     ECX,[EAX]
  MOV     AX,[EAX+4]
  MOV     [EDX],ECX
  MOV     [EDX+4],AX
  RET
  @m07:   MOV     ECX,[EAX]
  MOV     EAX,[EAX+3]
  MOV     [EDX],ECX
  MOV     [EDX+3],EAX
  RET
  @m08:   MOV     ECX,[EAX]
  MOV     EAX,[EAX+4]
  MOV     [EDX],ECX
  MOV     [EDX+4],EAX
End;

Procedure FillCharX87;
Asm // eax=Dest edx=Count cl=Value
        // faster version by John O'Harrow  (Code Size = 153 Bytes)
  CMP   EDX,32
  MOV   CH,CL                 // copy value into both bytes of cx
  JL    @small
  MOV   [EAX  ],CX            // fill first 8 bytes
  MOV   [EAX+2],CX
  MOV   [EAX+4],CX
  MOV   [EAX+6],CX
  SUB   EDX,16
  FLD   qword ptr [EAX]
  FST   qword ptr [EAX+EDX]    // fill last 16 bytes
  FST   qword ptr [EAX+EDX+8]
  MOV   ECX,EAX
  AND   ECX,7                 // 8-byte align writes
  SUB   ECX,8
  SUB   EAX,ECX
  ADD   EDX,ECX
  ADD   EAX,EDX
  NEG   EDX
  @loop:  FST   qword ptr [EAX+EDX]    // fill 16 bytes per loop
  FST   qword ptr [EAX+EDX+8]
  ADD   EDX,16
  JL    @loop
  FFREE ST(0)
  FINCSTP
  RET
  NOP
  @small: TEST  EDX,EDX
  JLE   @done
  MOV   [EAX+EDX-1],CL        // fill last byte
  AND   EDX,-2                // no. of words to fill
  NEG   EDX
  LEA   EDX,[@fill+60+EDX*2]
  JMP   EDX
  NOP                          // align jump destinations
  NOP
  @fill:  MOV   [EAX+28],CX
  MOV   [EAX+26],CX
  MOV   [EAX+24],CX
  MOV   [EAX+22],CX
  MOV   [EAX+20],CX
  MOV   [EAX+18],CX
  MOV   [EAX+16],CX
  MOV   [EAX+14],CX
  MOV   [EAX+12],CX
  MOV   [EAX+10],CX
  MOV   [EAX+ 8],CX
  MOV   [EAX+ 6],CX
  MOV   [EAX+ 4],CX
  MOV   [EAX+ 2],CX
  MOV   [EAX   ],CX
  RET                         // for alignment
  @done:  DB $f3 // rep ret AMD trick here
End;

(******************************************************************************)

const
  EQUAL_EACH = 8;

function StrLenSSE42(S: pointer): PtrInt;
asm // warning: may read up to 15 bytes beyond the string itself
        or        eax,eax
        mov       edx,eax             // copy pointer
        jz        @null               // returns 0 if S=nil
        xor       eax,eax
        pxor      xmm0,xmm0
        {$ifdef HASAESNI}
        pcmpistri xmm0,dqword [edx],EQUAL_EACH  // comparison result in ecx
        {$else}
        db $66,$0F,$3A,$63,$02,EQUAL_EACH
        {$endif}
        jnz       @loop
        mov       eax,ecx
@null:  ret
@loop:  add       eax,16
        {$ifdef HASAESNI}
        pcmpistri xmm0,dqword [edx+eax],EQUAL_EACH  // comparison result in ecx
        {$else}
        db $66,$0F,$3A,$63,$04,$10,EQUAL_EACH
        {$endif}
        jnz       @loop
@ok:    add       eax,ecx
end;

{$ifdef CPUX64}
function StrLenSSE2(S: pointer): PtrInt;
asm // from GPL strlen64.asm by Agner Fog - www.agner.org/optimize
        .NOFRAME
        mov      rax,rcx             // get pointer to string from rcx
        or       rax,rax
        mov      r8,rcx              // copy pointer
        jz       @null               // returns 0 if S=nil
        // rax = s,ecx = 32 bits of s
        pxor     xmm0,xmm0           // set to zero
        and      ecx,0FH             // lower 4 bits indicate misalignment
        and      rax,-10H            // align pointer by 16
        movdqa   xmm1,[rax]          // read from nearest preceding boundary
        pcmpeqb  xmm1,xmm0           // compare 16 bytes with zero
        pmovmskb edx,xmm1            // get one bit for each byte result
        shr      edx,cl              // shift out false bits
        shl      edx,cl              // shift back again
        bsf      edx,edx             // find first 1-bit
        jnz      @L2                 // found
        // Main loop, search 16 bytes at a time
@L1:    add      rax,10H             // increment pointer by 16
        movdqa   xmm1,[rax]          // read 16 bytes aligned
        pcmpeqb  xmm1,xmm0           // compare 16 bytes with zero
        pmovmskb edx,xmm1            // get one bit for each byte result
        bsf      edx,edx             // find first 1-bit
        // (moving the bsf out of the loop and using test here would be faster
        // for long strings on old processors, but we are assuming that most
        // strings are short, and newer processors have higher priority)
        jz       @L1                 // loop if not found
@L2:    // Zero-byte found. Compute string length
        sub      rax,r8              // subtract start address
        add      rax,rdx             // add byte index
@null:
end;

procedure FillCharSSE2;
asm  // rcx=Dest rdx=Count r8=Value
        .noframe
        cmp rdx,32
        mov rax,r8
        jle @small
        and r8,0FFH
        mov r9,101010101010101H
        imul r8,r9
        test cl,07H
        jz @27C5
        test cl,01H
        jz @27A4
        mov [rcx],r8b
        add rcx,1
        sub rdx,1
@27A4:  test cl,02H
        jz @27B5
        mov [rcx],r8w
        add rcx,2
        sub rdx,2
@27B5:  test cl,04H
        jz @27C5
        mov [rcx],r8d
        add rcx,4
        sub rdx,4
@27C5:  mov rax,rdx
        and rdx,3FH
        shr rax,6
        jnz @27FD
@27D2:  mov rax,rdx
        and rdx,07H
        shr rax,3
        jz @27EC
        db 66H,66H,90H
@27E0:  mov [rcx],r8
        add rcx,8
        dec rax
        jnz @27E0
@27EC:  test rdx,rdx
        jle @27FC
@27F1:  mov [rcx],r8b
        inc rcx
        dec rdx
        jnz @27F1
@27FC:  ret
@27FD:  cmp rax,8192
        jnc @2840
        db 66H,66H,66H,90H,90H,90H
@2810:  add rcx,64
        mov [rcx-40H],r8
        mov [rcx-38H],r8
        mov [rcx-30H],r8
        mov [rcx-28H],r8
        dec rax
        mov [rcx-20H],r8
        mov [rcx-18H],r8
        mov [rcx-10H],r8
        mov [rcx-8H],r8
        jnz @2810
        jmp @27D2
        db 66H,66H,66H,90H,90H
@2840:  add rcx,64
        db $4C,$0F,$C3,$41,$C0 // movnti  [rcx-40H],r8
        db $4C,$0F,$C3,$41,$C8 // movnti  [rcx-38H],r8
        db $4C,$0F,$C3,$41,$D0 // movnti  [rcx-30H],r8
        db $4C,$0F,$C3,$41,$D8 // movnti  [rcx-28H],r8
        dec rax
        db $4C,$0F,$C3,$41,$E0 // movnti  [rcx-20H],r8
        db $4C,$0F,$C3,$41,$E8 // movnti  [rcx-18H],r8
        db $4C,$0F,$C3,$41,$F0 // movnti  [rcx-10H],r8
        db $4C,$0F,$C3,$41,$F8 // movnti  [rcx-8H],r8
        jnz @2840
        mfence
        jmp @27D2
@small: // rcx=Dest rdx=Count r8=Value<=32
        test rdx,rdx
        jle @@done
        mov ah,al
        mov [rcx+rdx-1],al
        lea r8,@table
        and rdx,-2
        neg rdx
        lea rdx,[r8+rdx*2+64]
        jmp rdx
@table: mov [rcx+30],ax
        mov [rcx+28],ax
        mov [rcx+26],ax
        mov [rcx+24],ax
        mov [rcx+22],ax
        mov [rcx+20],ax
        mov [rcx+18],ax
        mov [rcx+16],ax
        mov [rcx+14],ax
        mov [rcx+12],ax
        mov [rcx+10],ax
        mov [rcx+ 8],ax
        mov [rcx+ 6],ax
        mov [rcx+ 4],ax
        mov [rcx+ 2],ax
        mov [rcx   ],ax
        ret
@@done:
end;
{$Else}
function StrLenSSE2(S: pointer): PtrInt;
asm // from GPL strlen32.asm by Agner Fog - www.agner.org/optimize
        or       eax,eax
        mov      ecx,eax             // copy pointer
        jz       @null               // returns 0 if S=nil
        push     eax                 // save start address
        pxor     xmm0,xmm0           // set to zero
        and      ecx,0FH             // lower 4 bits indicate misalignment
        and      eax,-10H            // align pointer by 16
        movdqa   xmm1,[eax]          // read from nearest preceding boundary
        pcmpeqb  xmm1,xmm0           // compare 16 bytes with zero
        pmovmskb edx,xmm1            // get one bit for each byte result
        shr      edx,cl              // shift out false bits
        shl      edx,cl              // shift back again
        bsf      edx,edx             // find first 1-bit
        jnz      @A200               // found
        // Main loop, search 16 bytes at a time
@A100:  add      eax,10H             // increment pointer by 16
        movdqa   xmm1,[eax]          // read 16 bytes aligned
        pcmpeqb  xmm1,xmm0           // compare 16 bytes with zero
        pmovmskb edx,xmm1            // get one bit for each byte result
        bsf      edx,edx             // find first 1-bit
        // (moving the bsf out of the loop and using test here would be faster
        // for long strings on old processors, but we are assuming that most
        // strings are short, and newer processors have higher priority)
        jz       @A100               // loop if not found
@A200:  // Zero-byte found. Compute string length
        pop      ecx                 // restore start address
        sub      eax,ecx             // subtract start address
        add      eax,edx             // add byte index
@null:
end;

procedure FillCharSSE2;
asm // Dest=eax Count=edx Value=cl
  cmp       edx, 32
  mov       ch,cl                {copy value into both bytes of cx}
  jl        @@small
  sub       edx,16
  movd      xmm0,ecx
  pshuflw   xmm0,xmm0,0
  pshufd    xmm0,xmm0,0
  movups    [eax],xmm0           {fill first 16 bytes}
  movups    [eax+edx],xmm0       {fill last 16 bytes}
  mov       ecx,eax              {16-byte align writes}
  and       ecx,15
  sub       ecx,16
  sub       eax,ecx
  add       edx,ecx
  add       eax,edx
  neg       edx
  cmp       edx,-512*1024
  jb        @@large
@@loop:
  movaps    [eax+edx],xmm0       {fill 16 bytes per loop}
  add       edx,16
  jl        @@loop
  ret
@@large:
  movntdq    [eax+edx],xmm0      {fill 16 bytes per loop}
  add       edx,16
  jl        @@large
  ret
@@small:
  test      edx,edx
  jle       @@done
  mov       [eax+edx-1],cl       {fill last byte}
  and       edx,-2               {no. of words to fill}
  neg       edx
  lea       edx,[@@smallfill+60+edx*2]
  jmp       edx
  nop                             {align jump destinations}
  nop
@@smallfill:
  mov       [eax+28],cx
  mov       [eax+26],cx
  mov       [eax+24],cx
  mov       [eax+22],cx
  mov       [eax+20],cx
  mov       [eax+18],cx
  mov       [eax+16],cx
  mov       [eax+14],cx
  mov       [eax+12],cx
  mov       [eax+10],cx
  mov       [eax+ 8],cx
  mov       [eax+ 6],cx
  mov       [eax+ 4],cx
  mov       [eax+ 2],cx
  mov       [eax   ],cx
  ret {do not remove - this is for alignment}
@@done:
end;
{$EndIf}

(******************************************************************************)

Procedure Init();
Begin
  TestIntelCpuFeatures();
  
  {$ifdef CPUX64}
    StrLen := @StrLenSSE2;
    FillcharFast := @FillCharSSE2;
    MoveFast := @MoveSSE2;
  {$else}
    If cfSSE2 In CpuFeatures Then
    Begin
      If cfSSE42 In CpuFeatures Then
        StrLen := @StrLenSSE42
      Else
        StrLen := @StrLenSSE2;

      FillcharFast := @FillCharSSE2;
    End
    Else
    Begin
      StrLen := @StrLenX86;
      FillcharFast := @FillCharX87;
    End;
    MoveFast := @MoveX87; // SSE2 is not faster than X87 version on 32 bit CPU
  {$endif}
End;

Function PadL(Const AString : String; Const ALen : Integer; Const AChar : Char = ' ') : String;
Var X : Integer;
Begin
  Result := AString;
  For X := 1 To ALen - Length(AString) Do
    Result := AChar + Result;
End;

Function PushZero(Const AString : String; Const ALen : Integer) : String;
Begin
  Result := PadL(AString, ALen, '0');
End;

Function PushZeroR(Const AString : String; Const ALen : Integer) : String;
Var X : Integer;
Begin
  Result := AString;
  For X := 1 To ALen - Length(AString) Do
    Result := Result + '0';
End;

Function UnPushZeroR(Const AString : String) : String;
Var X : Integer;
Begin
  Result := AString;

  For X := Length(AString) DownTo 1 Do
    If AString[X] <> '0' Then
    Begin
      Result := Copy(AString, 1, X);
      Break;
    End;
End;

Function MessageConfirm(Const AMessage : String) : Boolean;
Begin
  Result := MessageDlg(AMessage, mtInformation, [mbYes, mbNo], 0) = mrYes;
End;

Procedure AppLogFile(Const AMessage : String; AFileName : String = ''; AWriteDate : Boolean = True);
Var FName : String;
Begin
  With TStringList.Create() Do
  Try
    If AFileName = '' Then
      FName := ChangeFileExt(ParamStr(0), '.log')
    Else
      FName := AFileName;

    If FileExists(FName) Then
      LoadFromFile(FName);

    If AWriteDate Then
      Add(FormatDateTime('ddmmyy:hhmmss.zzz - ', Now) + AMessage)
    Else
      Add(AMessage);

    SaveToFile(FName);

    Finally
      Free();
  End;
End;

Initialization
  Init();

end.
