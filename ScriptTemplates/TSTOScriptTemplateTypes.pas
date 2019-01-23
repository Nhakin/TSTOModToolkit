unit TSTOScriptTemplateTypes;

interface

Type
  TScriptTemplateFunction = ( stfCustom, stfBuildStoreMenu, stfBuildInventoryMenu,
                              stfBuildStoreReqs, stfBuildStoreItems, stfBuildDeleteBadItems,
                              stfBuildFreeItems, stfBuildUniqueItems,
                              stfBuildReqsItems, stfBuildNonSellableItems );
 TScriptTemplateFunctions = Set Of TScriptTemplateFunction;

implementation

end.
