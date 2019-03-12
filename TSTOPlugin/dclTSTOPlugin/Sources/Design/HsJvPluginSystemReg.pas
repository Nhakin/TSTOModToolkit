{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvPluginReg.PAS, released on 2002-05-26.

The Initial Developer of the Original Code is John Doe.
Portions created by John Doe are Copyright (C) 2003 John Doe.
All Rights Reserved.

Contributor(s):

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.delphi-jedi.org

Known Issues:
-----------------------------------------------------------------------------}
// $Id$

unit HsJvPluginSystemReg;

interface

procedure Register;

implementation

uses
  Classes,
  DesignEditors, DesignIntf, VCLEditors,
  ToolsAPI,
//  JvDsgnConsts,
  HsJvPlugin, HsJvPluginManager, HsJvPluginWizard, HsJvPluginParamsForm;

{$R JvPluginSystemReg.dcr}

type
  TJvDelphiPluginWizardForm = class(TJvPluginWizardDelphi)
  public
    procedure InitializeWizard; override;
  end;

procedure Register;
begin
  RegisterComponents(RsPalettePlugin, [TJvPluginManager]);

  // Bianconi
  RegisterPropertyEditor(TypeInfo(TShortCut), TJvPluginCommand,
    'ShortCut', TShortCutProperty);
  // End of Bianconi

  //RegisterPackageWizard(TJvPluginWizard.Create);
  //  RegisterLibraryExpert(TJvPluginWizard.Create);

  RegisterPackageWizard(TJvDelphiPluginWizardForm.Create);
end;

{ TJvDelphiPluginWizardForm }

procedure TJvDelphiPluginWizardForm.InitializeWizard;
begin
  inherited;
  Caption := RsJvPluginWizard + ' for Delphi';
  UniqueID := RsPluginWizardIDString + '.delphi';
end;
  
end.