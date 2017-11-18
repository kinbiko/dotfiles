let mapleader = ','

"{{{ Special intellij mappings <3
nnoremap ] :action GotoDeclaration<CR>
nnoremap [ :action Back<CR>
nnoremap ? :action SearchEverywhere<CR>

nnoremap <leader><leader> :action ActivateProjectToolWindow<CR>
"}}}

nmap <BS> {
nmap <CR> }

nnoremap vv :vsp<CR>
nnoremap VV :sp<CR>

nmap t o<ESC>k
nmap T O<ESC>j

nmap Q @@

nnoremap j gj
nnoremap k gk

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap ; :

vmap <BS> {
vmap <CR> }

vnoremap jk <esc>

vmap < <gv
vmap > >gv

nnoremap * #
nnoremap # *

inoremap jk <esc>

"--- Actions ---
"$Copy                                              <M-C>
"$Cut                                               <M-X> <S-Del>
"$Delete                                            <Del> <BS> <M-BS>
"$LRU                                              
"$Paste                                             <M-V>
"$Redo                                              <M-S-Z> <A-S-BS>
"$SearchWeb                                        
"$SelectAll                                         <M-A>
"$Undo                                              <M-Z>
"About                                             
"Actions.ActionsPlugin.GenerateToString            
"ActivateAntBuildToolWindow                        
"ActivateCheckStyleToolWindow                      
"ActivateDebugToolWindow                            <M-5>
"ActivateDesignerToolWindow                        
"ActivateEventLogToolWindow                        
"ActivateFavoritesToolWindow                        <M-2>
"ActivateGradleToolWindow                          
"ActivateLuaCheckToolWindow                        
"ActivateMavenProjectsToolWindow                   
"ActivateNavBar                                    
"ActivatePalette	ToolWindow                        
"ActivateProjectToolWindow                          <M-1>
"ActivateRunToolWindow                              <M-4>
"ActivateStructureToolWindow                        <M-7>
"ActivateTerminalToolWindow                         <A-F12>
"ActivateTODOToolWindow                             <M-6>
"ActivateVersionControlToolWindow                   <M-9> <M-S-9>
"ActiveToolwindowGroup                             
"AddAllToFavorites                                 
"AddAntBuildFile                                   
"AddFrameworkSupport                               
"AddGradleDslPluginAction                          
"AddNewFavoritesList                               
"AddNewPropertyFile                                
"AddNewTabToTheEndMode                             
"AddToFavorites                                    
"AddToFavoritesPopup                                <A-S-F>
"AddToISuite                                       
"AlienCommitChangesDialog.AdditionalActions        
"AnalyzeActions                                    
"AnalyzeJavaMenu                                   
"AnalyzeMenu                                       
"Annotate                                          
"AnonymousToInner                                  
"AntBuildGroup                                     
"Arrangement.Alias.Rule.Add                         <M-N> <C-CR>
"Arrangement.Alias.Rule.Context.Menu               
"Arrangement.Alias.Rule.Edit                        <F2>
"Arrangement.Alias.Rule.Match.Condition.Move.Down   <A-Down>
"Arrangement.Alias.Rule.Match.Condition.Move.Up     <A-Up>
"Arrangement.Alias.Rule.Remove                      <Del> <BS> <M-BS>
"Arrangement.Alias.Rule.ToolBar                    
"Arrangement.Custom.Token.Rule.Edit                
"Arrangement.Rule.Add                               <M-N> <C-CR>
"Arrangement.Rule.Edit                              <F2>
"Arrangement.Rule.Group.Condition.Move.Down         <A-Down>
"Arrangement.Rule.Group.Condition.Move.Up           <A-Up>
"Arrangement.Rule.Group.Control.ToolBar            
"Arrangement.Rule.Match.Condition.Move.Down         <A-Down>
"Arrangement.Rule.Match.Condition.Move.Up           <A-Up>
"Arrangement.Rule.Match.Control.Context.Menu       
"Arrangement.Rule.Match.Control.ToolBar            
"Arrangement.Rule.Remove                            <Del> <BS> <M-BS>
"Arrangement.Rule.Section.Add                      
"AssociateWithFileType                             
"AttachProject                                     
"AutoIndentLines                                    <A-C-I>
"AutoShowProcessWindow                             
"Back                                               <M-[> <M-A-Left> button=4 clickCount=1 modifiers=0
"BackgroundTasks                                   
"BasicEditorPopupMenu                              
"Bookmarks                                         
"BuildArtifact                                     
"BuildMenu                                         
"ByteCodeDecompiler                                
"ByteCodeViewer                                    
"CallHierarchy                                      <A-C-H>
"CallHierarchy.BaseOnThisType                       <A-C-H>
"CallHierarchyPopupMenu                            
"ChangeCodeStyleScheme                             
"ChangeColorScheme                                 
"ChangeFileEncodingAction                          
"ChangeInspectionProfile                           
"ChangeKeymap                                      
"ChangeLaf                                         
"ChangeLineSeparators                              
"ChangeScheme                                      
"ChangeSignature                                    <M-F6>
"ChangeSplitOrientation                            
"ChangesView.AddUnversioned                         <M-A-A>
"ChangesView.AddUnversioned.From.Dialog             <M-A-A>
"ChangesView.ApplyPatch                            
"ChangesView.ApplyPatchFromClipboard               
"ChangesView.Browse                                
"ChangesView.CreatePatch                           
"ChangesView.CreatePatchFromChanges                
"ChangesView.CreatePatchToClipboard                
"ChangesView.DeleteUnversioned                     
"ChangesView.DeleteUnversioned.From.Dialog         
"ChangesView.Diff                                   <M-D>
"ChangesView.Edit                                  
"ChangesView.Ignore                                
"ChangesView.Move                                  
"ChangesView.NewChangeList                         
"ChangesView.Refresh                               
"ChangesView.RemoveChangeList                      
"ChangesView.RemoveDeleted                         
"ChangesView.Rename                                
"ChangesView.Revert                                 <M-A-Z>
"ChangesView.SetDefault                            
"ChangesView.Shelve                                
"ChangesView.ShelveSilently                         <M-A-H>
"ChangesView.UnshelveSilently                       <M-A-U>
"ChangesViewPopupMenu                              
"ChangesViewToolbar                                
"ChangeTemplateDataLanguage                        
"ChangeTypeSignature                                <M-S-F6>
"ChangeView                                        
"CheckComponentsUsageSearchAction                  
"CheckForUpdate                                    
"CheckinFiles                                      
"CheckinProject                                     <M-K>
"CheckPartialBodyResolve                           
"CheckStatusForFiles                               
"CheckStyleClearCheckCacheAction                   
"CheckStyleCloseAction                             
"CheckStyleCollapseAllAction                       
"CheckStyleCurrentFileAction                       
"CheckStyleDefaultChangeListAction                 
"CheckStyleDisplayErrorsAction                     
"CheckStyleDisplayInfoAction                       
"CheckStyleDisplayWarningsAction                   
"CheckStyleExpandAllAction                         
"CheckStyleModifiedFilesAction                     
"CheckStyleModuleFilesAction                       
"CheckStylePluginActions                           
"CheckStylePluginTreeActions                       
"CheckStyleProjectFilesAction                      
"CheckStyleScrollToSourceAction                    
"CheckStyleStopCheck                               
"ChooseDebugConfiguration                           <A-C-D>
"ChooseNextSubsequentPropertyValueEditorAction      <C-Down>
"ChoosePrevSubsequentPropertyValueEditorAction      <C-Up>
"ChooseRunConfiguration                             <A-C-R>
"ClassNameCompletion                                <A-C- >
"CloseActiveTab                                     <C-S-F4>
"CloseAllEditors                                   
"CloseAllEditorsButActive                          
"CloseAllNotifications                             
"CloseAllUnmodifiedEditors                         
"CloseAllUnpinnedEditors                           
"CloseContent                                       <M-W>
"CloseEditor                                       
"CloseEditorsGroup                                 
"CloseFirstNotification                            
"CloseProject                                      
"CodeCleanup                                       
"CodeCompletion                                     <C- >
"CodeCompletionGroup                               
"CodeEditorBaseGroup                               
"CodeEditorViewGroup                               
"CodeFormatGroup                                   
"CodeInsightEditorActions                          
"CodeInspection.OnEditor                            <A-S-I>
"CodeMenu                                          
"CollapseAll                                        <M-m> <M-->
"CollapseAllRegions                                 <M-S-m> <M-S-->
"CollapseBlock                                      <M-S-.>
"CollapseDocComments                               
"CollapseRegion                                     <M-m> <M-->
"CollapseRegionRecursively                          <M-A-m> <M-A-->
"CollapseSelection                                  <M-.>
"CollapseTreeNode                                   <m>
"CollectSettings                                   
"CollectZippedLogs                                 
"com.intellij.spellchecker.actions.SpellingPopupActionGroup
"CombinePropertiesFilesAction                      
"CommanderPopupMenu                                
"CommentByBlockComment                              <M-A-/> <M-A-o> <C-S-/> <C-S-o> <M-S-/> <M-S-o> <M-S-o>
"CommentByLineComment                               <M-/> <M-o>
"CommentGroup                                      
"CommittedChanges.Clear                            
"CommittedChanges.Details                          
"CommittedChanges.Filter                           
"CommittedChanges.Refresh                          
"CommittedChanges.Revert                           
"CommittedChangesToolbar                           
"Compare.LastVersion                               
"Compare.SameVersion                               
"Compare.Selected                                  
"Compare.Specified                                 
"CompareActions                                    
"CompareClipboardWithSelection                     
"CompareDirs                                        <M-D>
"CompareFileWithEditor                             
"CompareTwoFiles                                    <M-D>
"Compile                                            <M-S-F9>
"CompileDirty                                       <M-F9>
"CompileProject                                    
"CompilerErrorViewPopupMenu                        
"CompletionBindingContextCachingToggleAction       
"ConfigureIcs                                      
"ConfigureKotlinInProject                          
"ConfigureKotlinJsInProject                        
"Console.Execute                                    <CR>
"Console.Execute.Multiline                          <M-CR>
"Console.History.Browse                             <M-A-E>
"Console.History.Next                              
"Console.History.Previous                          
"Console.HistoryActions                            
"Console.Open                                       <M-S-F10>
"Console.SplitLine                                  <M-CR>
"ConsoleEditorPopupMenu                            
"ConsoleView.ClearAll                              
"ConsoleView.FoldLinesLikeThis                     
"ConsoleView.PopupMenu                             
"context.clear                                      <A-S-X>
"context.load                                      
"context.save                                      
"ContextHelp                                       
"ConvertGroovyToJava                               
"ConvertIndentsGroup                               
"ConvertIndentsToSpaces                            
"ConvertIndentsToTabs                              
"ConvertJavaToKotlin                                <M-A-S-K>
"ConvertSchemaAction                               
"ConvertToInstanceMethod                           
"ConvertToMacLineSeparators                        
"ConvertToUnixLineSeparators                       
"ConvertToWindowsLineSeparators                    
"CopyAsDiagnosticTest                               <M-A-S-T>
"CopyAsPlainText                                   
"CopyAsRichText                                    
"CopyElement                                        <F5>
"CopyPaths                                          <M-S-C>
"CopyReference                                      <M-A-S-C>
"CopyUrl                                           
"Coverage                                          
"CoverageMenu                                      
"CreateDesktopEntry                                
"CreateIncrementalCompilationBackup                
"CreateLauncherScript                              
"CreateLibraryFromFile                             
"CreateResourceBundle                              
"CreateRunConfiguration                            
"CutCopyPasteGroup                                 
"DashLauncherAction                                 <M-S-D>
"Debug                                              <C-D>
"DebugBuildProcess                                 
"DebugClass                                         <C-S-D>
"Debugger.AddSteppingFilter                        
"Debugger.AddToWatch                               
"Debugger.AdjustArrayRange                         
"Debugger.AutoRenderer                             
"Debugger.CreateRenderer                           
"Debugger.CustomizeContextView                     
"Debugger.CustomizeThreadsView                     
"Debugger.EditArrayFilter                           <F2>
"Debugger.EditCustomField                           <F2>
"Debugger.EditFrameSource                           <M-Down> <F4>
"Debugger.EditNodeSource                           
"Debugger.EditTypeSource                            <S-F4>
"Debugger.EvaluateInConsole                        
"Debugger.EvaluationDialogPopup                    
"Debugger.FilterArray                              
"Debugger.FocusOnBreakpoint                        
"Debugger.ForceEarlyReturn                         
"Debugger.FramePanelPopup                          
"Debugger.FreezeThread                             
"Debugger.InspectPanelPopup                        
"Debugger.InterruptThread                          
"Debugger.MarkObject                                <F3>
"Debugger.NewCustomField                           
"Debugger.PopFrame                                 
"Debugger.RemoveArrayFilter                         <Del> <BS> <M-BS>
"Debugger.RemoveCustomField                         <Del> <BS> <M-BS>
"Debugger.Representation                           
"Debugger.ResumeThread                             
"Debugger.ShowLibraryFrames                        
"Debugger.ShowReferring                            
"Debugger.ShowRelatedStack                         
"Debugger.ShowTypes                                
"Debugger.ThreadsPanelPopup                        
"Debugger.Tree.EvaluateInConsole                   
"Debugger.ViewAsGroup                              
"Debugger.ViewText                                 
"Debugger.WatchesPanelPopup                        
"DebugMainMenu                                     
"DecompileKotlinToJava                             
"DecrementWindowHeight                              <M-S-Up>
"DecrementWindowWidth                               <M-S-Left>
"DelegateMethods                                   
"DevkitNewActions                                  
"Diff.AppendLeftSide                               
"Diff.AppendRightSide                              
"Diff.ApplyLeftSide                                
"Diff.ApplyNonConflicts                            
"Diff.ApplyNonConflicts.Left                       
"Diff.ApplyNonConflicts.Right                      
"Diff.ApplyRightSide                               
"Diff.ComparePartial.Base.Left                     
"Diff.ComparePartial.Base.Right                    
"Diff.ComparePartial.Left.Right                    
"Diff.CompareWithBase.Left                         
"Diff.CompareWithBase.Result                       
"Diff.CompareWithBase.Right                        
"Diff.EditorGutterPopupMenu                        
"Diff.EditorGutterPopupMenu.EditorSettings         
"Diff.EditorPopupMenu                              
"Diff.FocusOppositePane                             <C-Tab>
"Diff.FocusOppositePaneAndScroll                    <C-S-Tab>
"Diff.HighlightMode                                
"Diff.IgnoreLeftSide                               
"Diff.IgnoreRightSide                              
"Diff.IgnoreWhitespace                             
"Diff.KeymapGroup                                  
"Diff.NextChange                                    <M-S-]> <C-Right>
"Diff.NextConflict                                 
"Diff.PrevChange                                    <M-S-[> <C-Left>
"Diff.PreviousConflict                             
"Diff.ResolveConflict                              
"Diff.SelectedChange                                <M-O>
"Diff.ShowDiff                                      <M-D>
"Diff.ShowInExternalTool                           
"Diff.ShowSettingsPopup                             <M-S-D>
"Diff.ViewerPopupMenu                              
"Diff.ViewerToolbar                                
"DiffPanel.Toolbar                                 
"DirDiffMenu                                       
"DirDiffMenu.EnableEqual                           
"DirDiffMenu.EnableLeft                            
"DirDiffMenu.EnableNotEqual                        
"DirDiffMenu.EnableRight                           
"DirDiffMenu.MirrorToLeft                          
"DirDiffMenu.MirrorToRight                         
"DirDiffMenu.SetCopyToLeft                         
"DirDiffMenu.SetCopyToRight                        
"DirDiffMenu.SetDefault                            
"DirDiffMenu.SetDelete                             
"DirDiffMenu.SetNoOperation                        
"DirDiffMenu.WarnOnDeletion                        
"DisableInspection                                 
"DissociateResourceBundleAction                    
"Document2XSD                                      
"DomCollectionControl                              
"DomCollectionControl.Add                           <Ins>
"DomCollectionControl.Edit                          <M-Down> <F4>
"DomCollectionControl.Remove                        <Del> <BS> <M-BS>
"DomElementsTreeView.AddElement                     <Ins>
"DomElementsTreeView.AddElementGroup               
"DomElementsTreeView.DeleteElement                  <Del> <BS> <M-BS>
"DomElementsTreeView.GotoDomElementDeclarationAction <M-Down> <F4>
"DomElementsTreeView.TreePopup                     
"DumpLookupElementWeights                           <M-A-S-W>
"DumpThreads                                       
"Dvcs.Log.ContextMenu                              
"Dvcs.Log.Toolbar                                  
"EditBookmarksGroup                                
"EditBreakpoint                                     <M-S-F8>
"EditCreateDeleteGroup                             
"EditCustomProperties                              
"EditCustomVmOptions                               
"EditFavorites                                     
"EditInspectionSettings                            
"EditMacros                                        
"EditMenu                                          
"EditorActions                                     
"EditorAddOrRemoveCaret                             button=1 clickCount=1 modifiers=576
"EditorAddRectangularSelectionOnMouseDrag           button=1 clickCount=1 modifiers=832
"EditorBackSpace                                    <BS> <S-BS>
"EditorBackwardParagraph                           
"EditorBidiTextDirection                           
"EditorBreadcrumbsHideBoth                         
"EditorBreadcrumbsSettings                         
"EditorBreadcrumbsShowAbove                        
"EditorBreadcrumbsShowBelow                        
"EditorChooseLookupItem                             <CR>
"EditorChooseLookupItemCompleteStatement            <M-S-CR>
"EditorChooseLookupItemDot                          <C-.>
"EditorChooseLookupItemReplace                      <Tab>
"EditorCloneCaretAbove                             
"EditorCloneCaretBelow                             
"EditorCodeBlockEnd                                 <M-A-]>
"EditorCodeBlockEndWithSelection                    <M-A-S-]>
"EditorCodeBlockStart                               <M-A-[>
"EditorCodeBlockStartWithSelection                  <M-A-S-[>
"EditorCompleteStatement                            <M-S-CR>
"EditorContextBarMenu                              
"EditorContextInfo                                  <C-S-Q>
"EditorCopy                                         <M-C>
"EditorCreateRectangularSelection                   button=2 clickCount=1 modifiers=576
"EditorCut                                          <M-X> <S-Del>
"EditorCutLineBackward                             
"EditorCutLineEnd                                   <C-K>
"EditorDecreaseFontSize                            
"EditorDelete                                       <Del>
"EditorDeleteLine                                   <M-BS>
"EditorDeleteToLineEnd                             
"EditorDeleteToLineStart                           
"EditorDeleteToWordEnd                              <A-Del>
"EditorDeleteToWordEndInDifferentHumpsMode         
"EditorDeleteToWordStart                            <A-BS>
"EditorDeleteToWordStartInDifferentHumpsMode       
"EditorDown                                         <Down> <C-N>
"EditorDownWithSelection                            <S-Down>
"EditorDuplicate                                    <M-D>
"EditorDuplicateLines                              
"EditorEnter                                        <CR>
"EditorEscape                                       <Esc>
"EditorForwardParagraph                            
"EditorGutterPopupMenu                             
"EditorGutterToggleGlobalIndentLines               
"EditorGutterToggleGlobalLineNumbers               
"EditorGutterToggleGlobalSoftWraps                 
"EditorGutterVcsPopupMenu                          
"EditorHungryBackSpace                             
"EditorIncreaseFontSize                            
"EditorIndentLineOrSelection                       
"EditorIndentSelection                              <Tab>
"EditorJoinLines                                    <C-S-J>
"EditorKillRegion                                  
"EditorKillRingSave                                
"EditorKillToWordEnd                               
"EditorKillToWordStart                             
"EditorLangPopupMenu                               
"EditorLeft                                         <Left> <C-B>
"EditorLeftWithSelection                            <S-Left>
"EditorLineEnd                                      <End> <M-Right> <C-E>
"EditorLineEndWithSelection                         <S-End> <M-S-Right>
"EditorLineStart                                    <Home> <M-Left> <C-A>
"EditorLineStartWithSelection                       <S-Home> <M-S-Left>
"EditorLookupDown                                   <C-Down>
"EditorLookupUp                                     <C-Up>
"EditorMatchBrace                                   <C-M>
"EditorMoveDownAndScroll                           
"EditorMoveDownAndScrollWithSelection              
"EditorMoveToPageBottom                             <M-Pagedown>
"EditorMoveToPageBottomWithSelection                <M-S-Pagedown>
"EditorMoveToPageTop                                <M-Pageup>
"EditorMoveToPageTopWithSelection                   <M-S-Pageup>
"EditorMoveUpAndScroll                             
"EditorMoveUpAndScrollWithSelection                
"EditorNextWord                                     <A-Right>
"EditorNextWordInDifferentHumpsMode                
"EditorNextWordInDifferentHumpsModeWithSelection   
"EditorNextWordWithSelection                        <A-S-Right>
"EditorPageDown                                     <Pagedown>
"EditorPageDownWithSelection                        <S-Pagedown>
"EditorPageUp                                       <Pageup>
"EditorPageUpWithSelection                          <S-Pageup>
"EditorPaste                                        <M-V>
"EditorPasteFromX11                                 button=2 clickCount=1 modifiers=0
"EditorPasteSimple                                  <M-A-S-V>
"EditorPopupMenu                                   
"EditorPopupMenu.GoTo                              
"EditorPopupMenu.Run                               
"EditorPopupMenu1                                  
"EditorPopupMenu1.FindRefactor                     
"EditorPopupMenu2                                  
"EditorPopupMenu3                                  
"EditorPopupMenuDebug                              
"EditorPopupMenuDebugJava                          
"EditorPreviousWord                                 <A-Left>
"EditorPreviousWordInDifferentHumpsMode            
"EditorPreviousWordInDifferentHumpsModeWithSelection
"EditorPreviousWordWithSelection                    <A-S-Left>
"EditorResetFontSize                               
"EditorRight                                        <Right> <C-F>
"EditorRightWithSelection                           <S-Right>
"EditorScrollBottom                                
"EditorScrollDown                                  
"EditorScrollDownAndMove                           
"EditorScrollLeft                                  
"EditorScrollRight                                 
"EditorScrollToCenter                              
"EditorScrollTop                                   
"EditorScrollUp                                    
"EditorScrollUpAndMove                             
"EditorSelectLine                                  
"EditorSelectWord                                   <A-Up>
"EditorSetContentBasedBidiTextDirection            
"EditorSetLtrBidiTextDirection                     
"EditorSetRtlBidiTextDirection                     
"EditorSplitLine                                    <M-CR>
"EditorStartNewLine                                 <S-CR>
"EditorStartNewLineBefore                           <M-A-CR>
"EditorSwapSelectionBoundaries                     
"EditorTab                                          <Tab>
"EditorTabCompileGroup                             
"EditorTabPopupMenu                                
"EditorTabPopupMenuEx                              
"EditorTabsGroup                                   
"EditorTextEnd                                      <M-End>
"EditorTextEndWithSelection                         <M-S-End>
"EditorTextStart                                    <M-Home>
"EditorTextStartWithSelection                       <M-S-Home>
"EditorToggleActions                               
"EditorToggleCase                                   <M-S-U>
"EditorToggleColumnMode                             <M-S-8>
"EditorToggleInsertState                           
"EditorToggleShowBreadcrumbs                       
"EditorToggleShowGutterIcons                       
"EditorToggleShowIndentLines                       
"EditorToggleShowLineNumbers                       
"EditorToggleShowWhitespaces                       
"EditorToggleStickySelection                       
"EditorToggleUseSoftWraps                          
"EditorToggleUseSoftWrapsInPreview                 
"EditorUnindentSelection                            <S-Tab>
"EditorUnSelectWord                                 <A-Down>
"EditorUp                                           <Up> <C-P>
"EditorUpWithSelection                              <S-Up>
"editRunConfigurations                             
"EditSelectGroup                                   
"EditSelectWordGroup                               
"EditSmartGroup                                    
"EditSource                                         <M-Down> <F4>
"EditSourceInNewWindow                              <S-F4>
"EmacsStyleIndent                                  
"Emmet                                             
"EmmetNextEditPoint                                 <A-C-Right>
"EmmetPreview                                      
"EmmetPreviousEditPoint                             <A-C-Left>
"EmmetUpdateTag                                    
"EmojiAndSymbols                                    <M-C- >
"EncapsulateFields                                 
"EscapeEntities                                    
"EvaluateExpression                                 <A-F8>
"ExcludeFromStubGeneration                         
"excludeFromSuite                                  
"ExcludeFromValidation                             
"Exit                                               <M-Q>
"ExpandAll                                          <M-k> <M-=>
"ExpandAllRegions                                   <M-S-k> <M-S-=>
"ExpandAllToLevel                                  
"ExpandAllToLevel1                                  <M-A-j> <M-A-j>
"ExpandAllToLevel2                                  <M-A-j> <M-A-j>
"ExpandAllToLevel3                                  <M-A-j> <M-A-j>
"ExpandAllToLevel4                                  <M-A-j> <M-A-j>
"ExpandAllToLevel5                                  <M-A-j> <M-A-j>
"ExpandDocComments                                 
"ExpandLiveTemplateByTab                            <Tab>
"ExpandLiveTemplateCustom                          
"ExpandRegion                                       <M-k> <M-=>
"ExpandRegionRecursively                            <M-A-k> <M-A-=>
"ExpandToLevel                                     
"ExpandToLevel1                                     <M-j> <M-j>
"ExpandToLevel2                                     <M-j> <M-j>
"ExpandToLevel3                                     <M-j> <M-j>
"ExpandToLevel4                                     <M-j> <M-j>
"ExpandToLevel5                                     <M-j> <M-j>
"ExpandTreeNode                                     <k>
"ExportImportGroup                                 
"ExportSettings                                    
"ExportTestResults                                 
"ExportThreads                                     
"ExportToHTML                                      
"ExportToTextFile                                   <C-O>
"ExpressionTypeInfo                                 <C-S-P>
"ExternalJavaDoc                                    <S-F1>
"ExternalSystem.Actions                            
"ExternalSystem.AfterCompile                       
"ExternalSystem.AfterRebuild                       
"ExternalSystem.AfterSync                          
"ExternalSystem.AssignRunConfigurationShortcut     
"ExternalSystem.AssignShortcut                     
"ExternalSystem.AttachProject                      
"ExternalSystem.BeforeCompile                      
"ExternalSystem.BeforeRebuild                      
"ExternalSystem.BeforeRun                          
"ExternalSystem.BeforeSync                         
"ExternalSystem.CollapseAll                         <M-m> <M-->
"ExternalSystem.DetachProject                       <Del> <BS> <M-BS>
"ExternalSystem.EditRunConfiguration               
"ExternalSystem.ExpandAll                           <M-k> <M-=>
"ExternalSystem.GroupTasks                         
"ExternalSystem.IgnoreProject                      
"ExternalSystem.OpenConfig                          <M-Down> <F4>
"ExternalSystem.OpenTasksActivationManager         
"ExternalSystem.RefreshAllProjects                 
"ExternalSystem.RefreshProject                     
"ExternalSystem.RemoveRunConfiguration             
"ExternalSystem.RunTask                            
"ExternalSystem.SelectProjectDataToImport          
"ExternalSystem.ShowIgnored                        
"ExternalSystem.ShowInheritedTasks                 
"ExternalSystem.ShowSettings                       
"ExternalSystem.ToggleAutoImport                   
"ExternalSystemView.ActionsToolbar                 
"ExternalSystemView.ActionsToolbar.CenterPanel     
"ExternalSystemView.ActionsToolbar.LeftPanel       
"ExternalSystemView.ActionsToolbar.RightPanel      
"ExternalSystemView.BaseProjectMenu                
"ExternalSystemView.ModuleMenu                     
"ExternalSystemView.ProjectMenu                    
"ExternalSystemView.RunConfigurationMenu           
"ExternalSystemView.TaskActivationGroup            
"ExternalSystemView.TaskMenu                       
"ExternalToolsGroup                                
"ExtractClass                                      
"ExtractFunction                                    <M-A-M>
"ExtractFunctionToScope                             <M-A-S-M>
"ExtractInclude                                    
"ExtractInterface                                  
"ExtractMethod                                      <M-A-M>
"ExtractModule                                     
"ExtractSuperclass                                 
"FavoritesViewPopupMenu                            
"FileChooser                                       
"FileChooser.Delete                                 <Del> <BS> <M-BS>
"FileChooser.GotoDesktop                            <M-D>
"FileChooser.GotoHome                               <M-1>
"FileChooser.GotoJDK                               
"FileChooser.GotoModule                             <M-3>
"FileChooser.GotoProject                            <M-2>
"FileChooser.NewFile                               
"FileChooser.NewFolder                              <M-N>
"FileChooser.Refresh                                <M-A-Y>
"FileChooser.ShowHiddens                           
"FileChooser.TogglePathShowing                      <M-P>
"FileChooserToolbar                                
"FileHistory.KeymapGroup                           
"FileMainSettingsGroup                             
"FileMenu                                          
"FileOpenGroup                                     
"FileOtherSettingsGroup                            
"FileSettingsGroup                                 
"FileStructurePopup                                 <M-F12>
"FillParagraph                                     
"Find                                               <M-F>
"FindImplicitNothingAction                         
"FindInPath                                         <M-S-F>
"FindMenuGroup                                     
"FindModal                                         
"FindNext                                           <M-G>
"FindPrevious                                       <M-S-G>
"FindUsages                                         <A-F7> <M-U>
"FindUsagesInFile                                   <M-F7>
"FindWordAtCaret                                   
"FixDocComment                                     
"FoldingGroup                                      
"ForceRunToCursor                                   <M-A-F9>
"ForceStepInto                                      <A-S-F7>
"ForceStepOver                                      <A-S-F8>
"Forward                                            <M-]> <M-A-Right> button=5 clickCount=1 modifiers=0
"FullyExpandTreeNode                                <j>
"Gant.NewScript                                    
"Generate                                           <M-N> <C-CR>
"GenerateAntBuild                                  
"GenerateConstructor                               
"GenerateCopyright                                 
"GenerateCoverageReport                            
"GenerateCreateUI                                  
"GenerateDataMethod                                
"GenerateDTD                                       
"GenerateEquals                                    
"GenerateExternalization                           
"GenerateGetter                                    
"GenerateGetterAndSetter                           
"GenerateGroup                                     
"GenerateJavadoc                                   
"GeneratePattern                                   
"GenerateSetter                                    
"GenerateSetUpMethod                               
"GenerateSuperMethodCall                           
"GenerateTearDownMethod                            
"GenerateTestMethod                                
"GenerateXmlTag                                    
"Generify                                          
"Git.Add                                            <M-A-A>
"Git.Branches                                      
"Git.BranchOperationGroup                          
"Git.CheckoutRevision                              
"Git.Clone                                         
"Git.CompareWithBranch                             
"Git.Configure.Remotes                             
"Git.ContextMenu                                   
"Git.CreateNewBranch                               
"Git.CreateNewTag                                  
"Git.Fetch                                         
"Git.FileHistory.ContextMenu                       
"Git.Init                                          
"Git.Log                                           
"Git.Log.ContextMenu                               
"Git.Log.DeepCompare                               
"Git.Log.Toolbar                                   
"Git.LogContextMenu                                
"Git.Menu                                          
"Git.Merge                                         
"Git.Pull                                          
"Git.Rebase                                        
"Git.Rebase.Abort                                  
"Git.Rebase.Continue                               
"Git.Rebase.Skip                                   
"Git.RepositoryContextMenu                         
"Git.Reset                                         
"Git.Reset.In.Log                                  
"Git.ResolveConflicts                              
"Git.Revert.In.Log                                 
"Git.Reword.Commit                                  <F2> <S-F6>
"Git.SelectInGitLog                                
"Git.Stash                                         
"Git.Tag                                           
"Git.Uncommit                                      
"Git.Unstash                                       
"GitFileActions                                    
"Github.Create.Gist                                
"Github.Create.Pull.Request                        
"Github.Open.In.Browser                            
"Github.Rebase                                     
"Github.Share                                      
"GitRepositoryActions                              
"GotoAction                                         <M-S-A>
"GotoBookmark0                                      <C-0>
"GotoBookmark1                                      <C-1>
"GotoBookmark2                                      <C-2>
"GotoBookmark3                                      <C-3>
"GotoBookmark4                                      <C-4>
"GotoBookmark5                                      <C-5>
"GotoBookmark6                                      <C-6>
"GotoBookmark7                                      <C-7>
"GotoBookmark8                                      <C-8>
"GotoBookmark9                                      <C-9>
"GotoChangedFile                                    <M-O>
"GoToChangeMarkerGroup                             
"GotoClass                                          <M-O>
"GoToCodeGroup                                     
"GotoCustomRegion                                   <M-A-.>
"GotoDeclaration                                    <M-B> button=1 clickCount=1 modifiers=256 button=2 clickCount=1 modifiers=0
"GoToEditPointGroup                                
"GoToErrorGroup                                    
"GotoFile                                           <M-S-O>
"GotoImplementation                                 <M-A-B> button=1 clickCount=1 modifiers=768
"GotoLine                                           <M-L>
"GoToLinkTarget                                    
"GoToMenu                                          
"GoToMenuEx                                        
"GotoNextBookmark                                  
"GotoNextError                                      <F2> <M-S-N>
"GotoNextIncompletePropertyAction                   <F2> <M-S-N>
"GotoPreviousBookmark                              
"GotoPreviousError                                  <S-F2>
"GotoRelated                                        <M-C-Up>
"GotoSuperMethod                                   
"GotoSymbol                                         <M-A-O>
"GoToTargetEx                                      
"GotoTest                                           <M-S-T>
"GotoTypeDeclaration                                <M-S-B> <C-S-B> button=1 clickCount=1 modifiers=320 button=2 clickCount=1 modifiers=64
"Gradle.AddGradleDslDependencyAction               
"Gradle.ExecuteTask                                
"Gradle.GenerateGroup                              
"Gradle.OpenProjectCompositeConfiguration          
"Gradle.RefreshDependencies                        
"Gradle.ToggleOfflineAction                        
"Griffon.UpdateDependencies                        
"Groovy.CheckResources                             
"Groovy.CheckResources.Make                        
"Groovy.CheckResources.Rebuild                     
"Groovy.Console                                    
"Groovy.Doc.Generating                             
"Groovy.Dynamic.CollapseAll                        
"Groovy.Dynamic.ExpandAll                          
"Groovy.Dynamic.Remove                             
"Groovy.Dynamic.Toolbar                            
"Groovy.NewClass                                   
"Groovy.NewScript                                  
"groovy.scripting.shell                            
"Groovy.Shell                                      
"Groovy.Shell.Execute                               <M-CR>
"GroovyGenerateGroup1                              
"Help.JetBrainsTV                                  
"Help.KeymapReference                              
"HelpMenu                                          
"HelpTopics                                        
"Hg.Init                                           
"Hg.Log.ContextMenu                                
"Hg.Mq                                             
"Hg.MQ.Unapplied                                   
"hg4idea.branches                                  
"hg4idea.CompareWithBranch                         
"hg4idea.CreateNewBranch                           
"hg4idea.CreateNewTag                              
"hg4idea.file.menu                                 
"hg4idea.Graft.Continue                            
"hg4idea.merge.files                               
"hg4idea.MergeWithRevision                         
"hg4idea.mq.ShowUnAppliedPatches                   
"hg4idea.pull                                      
"hg4idea.QDelete                                    <Del> <BS> <M-BS>
"hg4idea.QFinish                                   
"hg4idea.QFold                                      <A-S-D>
"hg4idea.QGoto                                     
"hg4idea.QGotoFromPatches                           <A-S-G>
"hg4idea.QImport                                   
"hg4idea.QPushAction                                <A-S-P>
"hg4idea.QRefresh                                   <M-R>
"hg4idea.QRename                                   
"hg4idea.Rebase.Abort                              
"hg4idea.Rebase.Continue                           
"hg4idea.resolve.mark                              
"hg4idea.run.conflict.resolver                     
"hg4idea.tag                                       
"hg4idea.updateTo                                  
"hg4idea.UpdateToRevision                          
"HideActiveWindow                                   <S-Esc>
"HideAllWindows                                     <M-S-F12>
"HideCoverage                                      
"HideSideWindows                                   
"HierarchyGroup                                    
"HighlightUsagesInFile                              <M-S-F7>
"HippieBackwardCompletion                           <A-S-/>
"HippieCompletion                                   <A-/>
"Hotswap                                           
"I18nize                                           
"IDEACoverageMenu                                  
"IdeScriptingConsole                               
"Images.EditExternally                              <M-A-F4>
"Images.Editor.ActualSize                           <M-o> <M-/>
"Images.Editor.ToggleGrid                           <M-Þ>
"Images.Editor.ZoomIn                               <M-k> <M-=>
"Images.Editor.ZoomOut                              <M-m> <M-->
"Images.EditorPopupMenu                            
"Images.EditorToolbar                              
"Images.SetBackgroundImage                         
"Images.ShowThumbnails                              <M-S-T>
"Images.Thumbnails.AddTagGroup                     
"Images.Thumbnails.EnterAction                      <CR>
"Images.Thumbnails.Hide                             <M-W>
"Images.Thumbnails.RemoveTagGroup                  
"Images.Thumbnails.ToggleFileName                  
"Images.Thumbnails.ToggleFileSize                  
"Images.Thumbnails.ToggleRecursive                  <A-j>
"Images.Thumbnails.UpFolder                         <BS>
"Images.ThumbnailsPopupMenu                        
"Images.ThumbnailsToolbar                          
"Images.ToggleTransparencyChessboard               
"ImplementMethods                                   <C-I>
"ImportModule                                      
"ImportModuleFromImlFile                           
"ImportProject                                     
"ImportSettings                                    
"ImportTests                                       
"IncomingChanges.Refresh                           
"IncomingChangesToolbar                            
"IncrementalSearch                                 
"IncrementWindowHeight                              <M-S-Down>
"IncrementWindowWidth                               <M-S-Right>
"InferNullity                                      
"InheritanceToDelegation                           
"Inline                                             <M-A-N>
"InsertLiveTemplate                                 <M-J>
"InspectCode                                       
"InspectCodeGroup                                  
"InspectionToolWindow.TreePopup                    
"IntegrateFiles                                    
"IntroduceActionsGroup                             
"IntroduceConstant                                  <M-A-C>
"IntroduceField                                     <M-A-F>
"IntroduceFunctionalParameter                       <M-A-S-P>
"IntroduceFunctionalVariable                       
"IntroduceParameter                                 <M-A-P>
"IntroduceParameterObject                          
"IntroduceProperty                                  <M-A-F>
"IntroduceTypeAlias                                 <M-A-S-A>
"IntroduceTypeParameter                            
"IntroduceVariable                                  <M-A-V>
"InvalidateCaches                                  
"InvertBoolean                                     
"JavaCompileGroup                                  
"JavaDebuggerActions                               
"JavaGenerateGroup1                                
"JavaGenerateGroup2                                
"JavaMethodHierarchyPopupMenu                      
"JumpToColorsAndFonts                              
"JumpToLastChange                                   <M-S-BS>
"JumpToLastWindow                                   <F12>
"JumpToNextChange                                  
"Kotlin.NewFile                                    
"KotlinConfigureUpdates                            
"KotlinConsoleREPL                                 
"KotlinGenerateDataMethod                          
"KotlinGenerateEqualsAndHashCode                   
"KotlinGenerateGroup                               
"KotlinGenerateMavenCompileExecutionAction         
"KotlinGenerateMavenPluginAction                   
"KotlinGenerateMavenTestCompileExecutionAction     
"KotlinGenerateSecondaryConstructor                
"KotlinGenerateSetUpMethod                         
"KotlinGenerateTearDownMethod                      
"KotlinGenerateTestMethod                          
"KotlinGenerateToString                            
"KotlinInternalMode                                
"KotlinMavenGenerate                               
"KotlinShellExecute                                 <M-CR>
"KotlinToolsGroup                                  
"LangCodeInsightActions                            
"LanguageSpecificFoldingGroup                      
"LoadUnloadModules                                 
"LocalHistory                                      
"LocalHistory.PutLabel                             
"LocalHistory.ShowHistory                          
"LocalHistory.ShowSelectionHistory                 
"Log.FileHistory.KeymapGroup                       
"Log.KeymapGroup                                   
"LogDebugConfigure                                 
"LookupActions                                     
"lua.newFile                                       
"lua.newTutorial                                   
"LuaCheck                                          
"Macros                                            
"MacrosGroup                                       
"MainMenu                                          
"MaintenanceAction                                  <M-A-S-/>
"MaintenanceGroup                                  
"MainToolBar                                       
"MainToolBarSettings                               
"MakeAllJarsAction                                 
"MakeJarAction                                     
"MakeModule                                        
"MakeStatic                                        
"ManageProjectTemplatesAction                      
"ManageRecentProjects                              
"MarkAsContentRoot                                 
"MarkAsOriginalTypeAction                          
"MarkAsPlainTextAction                             
"Markdown.Toolbar.Left                             
"Markdown.Toolbar.Right                            
"MarkExcludeRoot                                   
"MarkFileAs                                        
"MarkGeneratedSourceRoot                           
"MarkGeneratedSourceRootGroup                      
"MarkNotificationsAsRead                           
"MarkRootGroup                                     
"MarkSourceRootGroup                               
"Maven.AddFileAsMavenProject                       
"Maven.AddManagedFiles                             
"Maven.AfterCompile                                
"Maven.AfterRebuild                                
"Maven.AlwaysShowArtifactId                        
"Maven.AssignShortcut                              
"Maven.BaseProjectMenu                             
"Maven.BeforeCompile                               
"Maven.BeforeRebuild                               
"Maven.BeforeRun                                   
"Maven.BuildMenu                                   
"Maven.CollapseAll                                  <M-m> <M-->
"Maven.DependencyMenu                              
"Maven.DownloadAllDocs                             
"Maven.DownloadAllGroup                            
"Maven.DownloadAllGroupPopup                       
"Maven.DownloadAllSources                          
"Maven.DownloadAllSourcesAndDocs                   
"Maven.DownloadSelectedDocs                        
"Maven.DownloadSelectedSources                     
"Maven.DownloadSelectedSourcesAndDocs              
"Maven.EditRunConfiguration                        
"Maven.ExecuteGoal                                 
"Maven.ExpandAll                                    <M-k> <M-=>
"Maven.GenerateGroup                               
"Maven.GlobalProjectMenu                           
"Maven.GroupProjects                               
"Maven.IgnoreProjects                              
"Maven.NavigatorActionsToolbar                     
"Maven.NavigatorProjectMenu                        
"Maven.OpenProfilesXml                             
"Maven.OpenSettingsXml                             
"Maven.RefactoringGroup                            
"Maven.Reimport                                    
"Maven.ReimportProject                             
"Maven.RemoveManagedFiles                          
"Maven.RemoveRunConfiguration                      
"Maven.RunBuild                                    
"Maven.RunConfigurationMenu                        
"Maven.ShowBasicPhasesOnly                         
"Maven.ShowEffectivePom                            
"Maven.ShowIgnored                                 
"Maven.ShowSettings                                
"Maven.ShowVersions                                
"Maven.TasksGroup                                  
"Maven.ToggleOffline                               
"Maven.ToggleProfile                               
"Maven.ToggleSkipTests                             
"Maven.UpdateFolders                               
"Maven.UpdateFoldersForProject                     
"MaximizeActiveDialog                              
"MaximizeToolWindow                                 <M-S-Þ>
"MemberPushDown                                    
"MembersPullUp                                     
"MemoryView.ClassesPopupActionGroup                
"MemoryView.EnableTrackingWithClosedWindow         
"MemoryView.JumpToTypeSource                       
"MemoryView.SettingsPopupActionGroup               
"MemoryView.ShowAllocationStackTrace               
"MemoryView.ShowInstances                          
"MemoryView.ShowInstancesFromDebuggerTree          
"MemoryView.ShowNewInstances                       
"MemoryView.ShowOnlyTracked                        
"MemoryView.ShowOnlyWithDiff                       
"MemoryView.ShowOnlyWithInstances                  
"MemoryView.TrackingAction.NewInstancesTracking    
"MergeSettings                                     
"MethodDown                                         <C-Down>
"MethodDuplicates                                  
"MethodHierarchy                                    <M-S-H>
"MethodHierarchy.BaseOnThisType                     <M-S-H>
"MethodHierarchy.ImplementMethodAction              <C-I>
"MethodHierarchy.OverrideMethodAction               <C-O>
"MethodHierarchyPopupMenu                          
"MethodOverloadSwitchDown                           <M-Down>
"MethodOverloadSwitchUp                             <M-Up>
"MethodUp                                           <C-Up>
"Migrate                                           
"MinimizeCurrentWindow                              <M-M>
"ModuleSettings                                    
"Move                                               <F6>
"MoveEditorToOppositeTabGroup                      
"MoveElementLeft                                    <M-A-S-Left>
"MoveElementRight                                   <M-A-S-Right>
"MoveLineDown                                       <A-S-Down>
"MoveLineUp                                         <A-S-Up>
"MoveModuleToGroup                                 
"MoveStatementDown                                  <M-S-Down>
"MoveStatementUp                                    <M-S-Up>
"MoveTabDown                                       
"MoveTabRight                                      
"Mq.Patches.ContextMenu                            
"Mq.Patches.Toolbar                                
"Mvc.Actions                                       
"Mvc.RunTarget                                      <M-A-G>
"Mvc.Upgrade                                       
"NavbarPopupMenu                                   
"NavBarToolBar                                     
"NavBarToolBarOthers                               
"NavBarVcsGroup                                    
"NewAction                                         
"NewApplicationComponent                           
"NewClass                                          
"NewDir                                            
"NewElement                                         <M-N> <C-CR>
"NewElementInMenuGroup                             
"NewElementSamePlace                                <A-C-N>
"NewFile                                           
"NewFromTemplate                                   
"NewFxmlFile                                       
"NewGroup                                          
"NewGroup1                                         
"NewHtmlFile                                       
"NewJavaSpecialFile                                
"NewModule                                         
"NewModuleComponent                                
"NewModuleInfo                                     
"NewModuleInGroup                                  
"NewPackageInfo                                    
"NewProject                                        
"NewProjectComponent                               
"NewProjectFromVCS                                 
"NewProjectOrModuleGroup                           
"NewPropertyAction                                 
"NewScratchBuffer                                  
"NewScratchFile                                    
"NewXml                                            
"NewXmlDescriptor                                  
"NextDiff                                           <F7>
"NextEditorTab                                      <C-S-Right>
"NextOccurence                                      <M-A-Down>
"NextParameter                                      <Tab>
"NextProjectWindow                                  <M-À>
"NextSplitter                                       <A-Tab>
"NextTab                                            <M-S-]> <C-Right>
"NextTemplateParameter                              <Tab>
"NextTemplateVariable                               <Tab> <CR>
"Notifications                                     
"OnlineDocAction                                   
"openAssertEqualsDiff                               <M-D>
"OpenEditorInOppositeTabGroup                      
"OpenElementInNewWindow                             <S-CR>
"OpenFile                                          
"OpenInBrowser                                     
"OpenInBrowserEditorContextBarGroupAction          
"OpenInBrowserGroup                                
"OpenInSceneBuilder                                
"OpenModuleSettings                                 <M-Down> <F4>
"OpenProjectGroup                                  
"OpenProjectWindows                                
"OptimizeImports                                    <A-C-O>
"org.intellij.plugins.markdown.ui.actions.editorLayout.CyclicSplitLayoutChangeAction <M-P>
"org.intellij.plugins.markdown.ui.actions.editorLayout.EditorAndPreviewLayoutChangeAction
"org.intellij.plugins.markdown.ui.actions.editorLayout.EditorOnlyLayoutChangeAction
"org.intellij.plugins.markdown.ui.actions.editorLayout.PreviewOnlyLayoutChangeAction
"org.intellij.plugins.markdown.ui.actions.styling.ToggleBoldAction
"org.intellij.plugins.markdown.ui.actions.styling.ToggleCodeSpanAction
"org.intellij.plugins.markdown.ui.actions.styling.ToggleItalicAction
"org.jetbrains.plugins.groovy.actions.generate.accessors.GroovyGenerateGetterAction
"org.jetbrains.plugins.groovy.actions.generate.accessors.GroovyGenerateGetterSetterAction
"org.jetbrains.plugins.groovy.actions.generate.accessors.GroovyGenerateSetterAction
"org.jetbrains.plugins.groovy.actions.generate.constructors.GroovyGenerateConstructorAction
"org.jetbrains.plugins.groovy.actions.generate.equals.GroovyGenerateEqualsAction
"org.jetbrains.plugins.groovy.actions.generate.missing.GroovyGenerateMethodMissingAction
"org.jetbrains.plugins.groovy.actions.generate.missing.GroovyGeneratePropertyMissingAction
"org.jetbrains.plugins.groovy.actions.generate.tostring.GroovyGenerateToStringAction
"Other.KeymapGroup                                 
"OtherMenu                                         
"OverrideMethods                                    <C-O>
"PackageFile                                        <M-S-F9>
"PairFileActions                                   
"ParameterInfo                                      <M-P>
"ParameterNameHints                                
"PasteMultiple                                      <M-S-V>
"Pause                                             
"PinActiveEditorTab                                
"PinActiveTab                                      
"PinToolwindowTab                                  
"PlaybackLastMacro                                 
"PlaySavedMacrosAction                             
"PluginDeployActions                               
"PopupHector                                        <M-A-S-H>
"PowerSaveGroup                                    
"PreviousDiff                                       <S-F7>
"PreviousEditorTab                                  <C-S-Left>
"PreviousOccurence                                  <M-A-Up>
"PreviousProjectWindow                              <M-S-À>
"PreviousTab                                        <M-S-[> <C-Left>
"PreviousTemplateVariable                           <S-Tab>
"PrevParameter                                      <S-Tab>
"PrevSplitter                                       <A-S-Tab>
"PrevTemplateParameter                              <S-Tab>
"Print                                             
"PrintExportGroup                                  
"PrintOutNotPropertyMatches                        
"ProductivityGuide                                 
"ProjectViewAnalysisGroup                          
"ProjectViewChangeView                              <A-F1>
"ProjectViewCompileGroup                           
"ProjectViewPopupMenu                              
"ProjectViewPopupMenuModifyGroup                   
"ProjectViewPopupMenuRefactoringGroup              
"ProjectViewPopupMenuRunGroup                      
"ProjectViewPopupMenuSettingsGroup                 
"PsiViewer                                         
"PsiViewerForContext                               
"QuickActionPopup                                   <M-A-CR>
"QuickActions                                      
"QuickChangeScheme                                  <C-À>
"QuickDocCopy                                       <M-C>
"QuickEvaluateExpression                            <M-A-F8> button=1 clickCount=1 modifiers=512
"QuickFixes                                        
"QuickImplementations                               <A- > <M-Y>
"QuickJavaDoc                                       <F1> <C-J> button=2 clickCount=1 modifiers=128
"RearrangeCode                                     
"RecentChangedFiles                                 <M-S-E>
"RecentChanges                                      <A-S-C>
"RecentFiles                                        <M-E>
"RecentProjectListGroup                            
"refactoring.extract.dependency                     <M-A-M>
"refactoring.introduce.property                     <M-A-V>
"RefactoringMenu                                   
"RefactoringMenu1                                  
"RefactoringMenu2                                  
"RefactoringMenu4                                  
"Refactorings.QuickListPopupAction                  <C-T>
"ReformatCode                                       <M-A-L>
"Refresh                                            <M-R>
"ReloadFromDisk                                    
"RemoteServers.ChooseServerDeployment              
"RemoteServers.ChooseServerDeploymentWithDebug     
"RemoteServers.ConnectServer                       
"RemoteServers.DisconnectServer                    
"RemoteServers.EditDeploymentConfig                
"RemoteServers.EditServerConfig                    
"RemoteServersViewPopup                            
"RemoteServersViewToolbar                          
"RemoteServersViewToolbar.Top                      
"RemoveMiddleman                                   
"RenameElement                                      <S-F6> <A-R>
"RenameFile                                        
"ReopenClosedTab                                   
"Replace                                            <M-R>
"ReplaceConstructorWithBuilder                     
"ReplaceConstructorWithFactory                     
"ReplaceInPath                                      <M-S-R>
"ReplaceMethodWithMethodObject                     
"ReplaceTempWithQuery                              
"RepositoryChangesBrowserToolbar                   
"Rerun                                              <M-R> <M-S> <C-S>
"RerunFailedTests                                  
"RerunTests                                         <M-C-R> <A-S-R> <M-S> <C-S>
"ResetToMySettings                                 
"ResetToTheirsSettings                             
"ResizeToolWindowDown                               <M-S-Down>
"ResizeToolWindowGroup                             
"ResizeToolWindowLeft                               <M-S-Left>
"ResizeToolWindowRight                              <M-S-Right>
"ResizeToolWindowUp                                 <M-S-Up>
"ResourceBundleEditorShowIntentions                 <A-CR>
"RestoreDefaultExtensionScripts                    
"RestoreDefaultLayout                               <S-F12>
"Resume                                             <M-A-R> <F9>
"RevealIn                                          
"Run                                                <C-R> <M-S> <C-S>
"RunClass                                           <C-S-R>
"RunConfiguration                                  
"RunContextGroup                                   
"RunContextGroupInner                              
"RunContextPopupGroup                              
"RunCoverage                                       
"RunDashboard.CopyConfiguration                     <M-D>
"RunDashboard.Debug                                
"RunDashboard.EditConfiguration                     <M-Down> <F4>
"RunDashboard.RemoveConfiguration                   <Del> <BS> <M-BS>
"RunDashboard.Run                                  
"RunDashboard.Stop                                 
"RunDashboardContentToolbar                        
"RunDashboardPopup                                 
"RunDashboardTreeToolbar                           
"RunGc                                             
"RunInspection                                      <M-A-S-I>
"RunInspectionOn                                   
"RunMenu                                           
"Runner.CloseAllUnpinnedViews                      
"Runner.CloseAllViews                              
"Runner.CloseOtherViews                            
"Runner.CloseView                                  
"Runner.Focus                                      
"Runner.FocusOnStartup                             
"Runner.Layout                                     
"Runner.MinimizeView                               
"Runner.RestoreLayout                              
"Runner.View.Close.Group                           
"Runner.View.Popup                                 
"Runner.View.Toolbar                               
"RunnerActions                                     
"RunnerLayoutActions                               
"RunTargetAction                                    <M-S-F10>
"RunToCursor                                        <A-F9>
"SafeDelete                                         <M-Del>
"SaveAll                                           
"SaveAsNewFormat                                   
"SaveAsTemplate                                    
"SaveDocument                                      
"SaveFileAsTemplate                                
"SaveProjectAsTemplateAction                       
"ScopeView.EditScopes                              
"ScopeViewPopupMenu                                
"Scratch.ChangeLanguage                            
"ScrollPane-scrollDown                             
"ScrollPane-scrollEnd                              
"ScrollPane-scrollHome                             
"ScrollPane-scrollLeft                             
"ScrollPane-scrollRight                            
"ScrollPane-scrollUp                               
"ScrollPane-unitScrollDown                         
"ScrollPane-unitScrollLeft                         
"ScrollPane-unitScrollRight                        
"ScrollPane-unitScrollUp                           
"ScrollPaneActions                                 
"ScrollTreeToCenter                                
"SearchEverywhere                                  
"SelectAllOccurrences                               <M-C-G>
"SelectIn                                           <A-F1>
"SelectInProjectView                               
"SelectNextOccurrence                               <C-G>
"SendEOF                                            <M-D>
"SendFeedback                                      
"SendToFavoritesGroup                              
"Servers.Deploy                                    
"Servers.DeployWithDebug                           
"Servers.Undeploy                                  
"SeverityEditorDialog                              
"ShelfChanges.Settings                             
"Shelve.KeymapGroup                                
"ShelveChanges.UnshelveWithDialog                   <M-S-U>
"ShelvedChanges.CleanMarkedToDelete                
"ShelvedChanges.ImportPatches                      
"ShelvedChanges.Rename                              <S-F6> <A-R>
"ShelvedChanges.Restore                            
"ShelvedChanges.ShowHideDeleted                    
"ShelvedChangesPopupMenu                           
"ShelvedChangesToolbar                             
"Show.Current.Revision                             
"ShowBackwardPackageDeps                           
"ShowBookmarks                                      <M-F3>
"ShowColorPicker                                   
"ShowContent                                        <C-Down>
"ShowDependenciesOnTarget                          
"ShowErrorDescription                               <M-F1>
"ShowExecutionPoint                                 <A-F10>
"ShowFilePath                                       <M-A-F12>
"ShowIntentionActions                               <A-CR>
"ShowKotlinBytecode                                
"ShowLiveRunConfigurations                         
"ShowLog                                           
"ShowModulesDependencies                           
"ShowNavBar                                         <M-Up> <A-Home>
"ShowPackageCycles                                 
"ShowPackageDeps                                   
"ShowPackageDepsGroup                              
"ShowPopupMenu                                     
"ShowProcessWindow                                 
"ShowProjectStructureSettings                       <M-;>
"ShowRecentFindUsagesGroup                         
"ShowRecentTests                                    <M-S-;>
"ShowReformatFileDialog                             <M-A-S-L>
"ShowRegistry                                      
"ShowSettings                                       <M-,>
"ShowSettingsAndFindUsages                          <M-A-S-F7>
"ShowSettingsWithAddedPattern                      
"ShowSiblings                                      
"ShowTabsInSingleRow                               
"ShowTips                                          
"ShowUsages                                         <M-A-F7>
"SliceBackward                                     
"SliceForward                                      
"SmartStepInto                                      <S-F7>
"SmartTypeCompletion                                <C-S- >
"SplitHorizontally                                 
"SplitVertically                                   
"StandardMacroActions                              
"Start.Use.Vcs                                     
"StartStopMacroRecording                           
"StartupWizard                                     
"StepInto                                           <F7>
"StepOut                                            <S-F8>
"StepOver                                           <F8>
"Stop                                               <M-F2>
"StopBackgroundProcesses                            <M-S-F2>
"StoreDefaultLayout                                
"StoredExceptionsThrowToggleAction                 
"StructuralSearchActions                           
"StructuralSearchPlugin.StructuralReplaceAction    
"StructuralSearchPlugin.StructuralSearchAction     
"StructureViewCompileGroup                         
"StructureViewPopupMenu                            
"SuppressFixes                                     
"SurroundWith                                       <M-A-T>
"SurroundWithEmmet                                 
"SurroundWithLiveTemplate                           <M-A-J>
"SwitchBootJdk                                     
"SwitchCoverage                                     <M-A-F6>
"Switcher                                           <C-Tab> <C-S-Tab>
"Synchronize                                        <M-A-Y>
"SynchronizeCurrentFile                            
"SyncSettings                                      
"TabList                                           
"TabsAlphabeticalMode                              
"TabsPlacementBottom                               
"TabsPlacementGroup                                
"TabsPlacementLeft                                 
"TabsPlacementNone                                 
"TabsPlacementRight                                
"TabsPlacementTop                                  
"task.actions                                      
"tasks.analyze.stacktrace                          
"tasks.and.contexts                                
"tasks.close                                        <A-S-W>
"tasks.configure.servers                           
"tasks.create.changelist                           
"tasks.edit                                        
"tasks.goto                                         <A-S-N>
"tasks.group                                       
"tasks.open.in.browser                              <A-S-B>
"tasks.show.task.description                       
"tasks.switch                                       <A-S-T>
"tasks.toolbar.group                               
"TechnicalSupport                                  
"TemplateParametersNavigation                      
"TemplateProjectProperties                         
"TemplateProjectSettingsGroup                      
"TemplateProjectStructure                          
"TestData.Navigate                                  <M-C-Up>
"Testing.SelectInTree                              
"TestStatisticsTablePopupMenu                      
"TestTreePopupMenu                                 
"TextComponent.ClearAction                         
"ToggleBookmark                                     <F3>
"ToggleBookmark0                                    <C-S-0>
"ToggleBookmark1                                    <C-S-1>
"ToggleBookmark2                                    <C-S-2>
"ToggleBookmark3                                    <C-S-3>
"ToggleBookmark4                                    <C-S-4>
"ToggleBookmark5                                    <C-S-5>
"ToggleBookmark6                                    <C-S-6>
"ToggleBookmark7                                    <C-S-7>
"ToggleBookmark8                                    <C-S-8>
"ToggleBookmark9                                    <C-S-9>
"ToggleBookmarkWithMnemonic                         <A-F3>
"ToggleBreakpointAction                            
"ToggleBreakpointEnabled                           
"ToggleContentUiTypeMode                           
"ToggleDistractionFreeMode                         
"ToggleDockMode                                    
"ToggleFieldBreakpoint                             
"ToggleFloatingMode                                
"ToggleFullScreen                                   <M-C-F>
"ToggleFullScreenGroup                             
"ToggleInlineHintsAction                           
"ToggleLineBreakpoint                               <M-F8>
"ToggleMethodBreakpoint                            
"TogglePinnedMode                                  
"TogglePopupHints                                  
"TogglePowerSave                                   
"TogglePresentationMode                            
"ToggleReadOnlyAttribute                           
"ToggleSideMode                                    
"ToggleTemporaryLineBreakpoint                      <M-A-S-F8>
"ToggleWindowedMode                                
"ToolbarFindGroup                                  
"ToolbarMakeGroup                                  
"ToolbarRunGroup                                   
"ToolsBasicGroup                                   
"ToolsMenu                                         
"ToolsXmlGroup                                     
"ToolWindowsGroup                                  
"TreeNodeExclusion                                 
"TurnRefsToSuper                                   
"TypeHierarchy                                      <C-H>
"TypeHierarchy.BaseOnThisType                       <C-H>
"TypeHierarchy.Class                               
"TypeHierarchy.Subtypes                            
"TypeHierarchy.Supertypes                          
"TypeHierarchyBase.BaseOnThisType                   <C-H>
"TypeHierarchyPopupMenu                            
"UiDebugger                                        
"UIToggleActions                                   
"UnmarkGeneratedSourceRoot                         
"UnmarkRoot                                        
"Unscramble                                        
"UnselectPreviousOccurrence                         <C-S-G>
"Unsplit                                           
"UnsplitAll                                        
"Unversioned.Files.Dialog                          
"Unwrap                                             <M-S-Del>
"UpdateActionGroup                                 
"UpdateCopyright                                   
"UpdateFiles                                       
"UsageView.Exclude                                  <Del> <BS> <M-BS>
"UsageView.Include                                  <S-BS>
"UsageView.Popup                                   
"UsageView.Remove                                   <M-Del>
"UsageView.Rerun                                    <M-R> <M-S> <C-S>
"UsageView.ShowRecentFindUsages                     <M-E>
"ValidateXml                                       
"Vcs.Browse                                        
"Vcs.CheckinProjectPopup                           
"Vcs.CheckinProjectToolbar                         
"Vcs.Checkout                                      
"Vcs.CherryPick                                    
"Vcs.CopyRevisionNumberAction                      
"Vcs.FileHistory.ContextMenu                       
"Vcs.FileHistory.Toolbar                           
"Vcs.GetVersion                                    
"Vcs.History                                       
"Vcs.Import                                        
"Vcs.IntegrateProject                              
"Vcs.KeymapGroup                                   
"Vcs.Log.AnnotateRevisionAction                    
"Vcs.Log.CloseLogTabAction                         
"Vcs.Log.CollapseAll                               
"Vcs.Log.CompactReferencesView                     
"Vcs.Log.ContextMenu                               
"Vcs.Log.EnableFilterByRegexAction                 
"Vcs.Log.ExpandAll                                 
"Vcs.Log.FocusTextFilter                            <M-L>
"Vcs.Log.GetVersion                                
"Vcs.Log.GoToRef                                    <M-F>
"Vcs.Log.HighlightersActionGroup                   
"Vcs.Log.IntelliSortChooser                        
"Vcs.Log.MatchCaseAction                           
"Vcs.Log.OpenAnotherTab                            
"Vcs.Log.OpenRepositoryVersion                      <M-Down> <F4>
"Vcs.Log.QuickSettings                             
"Vcs.Log.QuickTextFilterSettings                   
"Vcs.Log.Refresh                                    <M-R>
"Vcs.Log.Settings                                  
"Vcs.Log.ShowAllAffected                            <M-C-A>
"Vcs.Log.ShowDetailsAction                         
"Vcs.Log.ShowLongEdges                             
"Vcs.Log.ShowOtherBranches                         
"Vcs.Log.ShowRootsColumnAction                     
"Vcs.Log.ShowTagNames                              
"Vcs.Log.ShowTooltip                                <F1> <C-J> button=2 clickCount=1 modifiers=128
"Vcs.Log.TextFilterSettings                        
"Vcs.Log.Toolbar                                   
"Vcs.Log.Toolbar.Internal                          
"Vcs.MessageActionGroup                            
"Vcs.Push                                           <M-S-K>
"Vcs.QuickListPopupAction                           <C-V>
"Vcs.ReformatCommitMessage                          <M-A-L>
"Vcs.RefreshStatuses                               
"Vcs.RollbackChangedLines                           <M-A-Z>
"Vcs.Show.Local.Changes                            
"Vcs.Show.Log                                      
"Vcs.Show.Shelf                                    
"Vcs.Show.Toolwindow.Tab                           
"Vcs.ShowDiffWithLocal                             
"Vcs.ShowHistoryForBlock                           
"Vcs.ShowHistoryForRevision                        
"Vcs.ShowMessageHistory                             <C-M> <M-E>
"Vcs.ShowTabbedFileHistory                         
"Vcs.Specific                                      
"Vcs.UpdateProject                                  <M-T>
"VcsFileGroupPopup                                 
"VcsGeneral.KeymapGroup                            
"VcsGlobalGroup                                    
"VcsGroup                                          
"VcsGroups                                         
"VcsHistory.ShowAllAffected                         <M-C-A>
"VcsHistoryActionsGroup                            
"VcsNavBarToobarActions                            
"VcsShowCurrentChangeMarker                        
"VcsShowNextChangeMarker                            <A-C-S-Down>
"VcsShowPrevChangeMarker                            <A-C-S-Up>
"VcsToobarActions                                  
"VersionControlsGroup                              
"ViewBreakpoints                                    <M-S-F8>
"ViewImportPopups                                  
"ViewMenu                                          
"ViewNavigationBar                                 
"ViewOfflineInspection                             
"ViewRecentActions                                 
"ViewSource                                         <M-CR>
"ViewStatusBar                                     
"ViewToolBar                                       
"ViewToolButtons                                   
"VimAutoIndentLines                                
"VimAutoIndentMotion                               
"VimAutoIndentVisual                               
"VimBack                                           
"VimCancelExEntry                                  
"VimChangeCaseLowerMotion                          
"VimChangeCaseLowerVisual                          
"VimChangeCaseToggleCharacter                      
"VimChangeCaseToggleMotion                         
"VimChangeCaseToggleVisual                         
"VimChangeCaseUpperMotion                          
"VimChangeCaseUpperVisual                          
"VimChangeCharacter                                
"VimChangeCharacters                               
"VimChangeEndOfLine                                
"VimChangeLine                                     
"VimChangeMotion                                   
"VimChangeNumberDec                                
"VimChangeNumberInc                                
"VimChangeReplace                                  
"VimChangeVisual                                   
"VimChangeVisualCharacter                          
"VimChangeVisualLines                              
"VimChangeVisualLinesEnd                           
"VimCopyPutTextAfterCursor                         
"VimCopyPutTextAfterCursorMoveCursor               
"VimCopyPutTextAfterCursorNoIndent                 
"VimCopyPutTextBeforeCursor                        
"VimCopyPutTextBeforeCursorMoveCursor              
"VimCopyPutTextBeforeCursorNoIndent                
"VimCopySelectRegister                             
"VimCopyYankLine                                   
"VimCopyYankMotion                                 
"VimCopyYankVisual                                 
"VimCopyYankVisualLines                            
"VimDeleteCharacter                                
"VimDeleteCharacterLeft                            
"VimDeleteCharacterRight                           
"VimDeleteEndOfLine                                
"VimDeleteJoinLines                                
"VimDeleteJoinLinesSpaces                          
"VimDeleteJoinVisualLines                          
"VimDeleteJoinVisualLinesSpaces                    
"VimDeleteLine                                     
"VimDeleteMotion                                   
"VimDeleteVisual                                   
"VimDeleteVisualLines                              
"VimDeleteVisualLinesEnd                           
"VimExBackspace                                    
"VimExEntry                                        
"VimFileGetAscii                                   
"VimFileGetFileInfo                                
"VimFileGetHex                                     
"VimFileGetLocationInfo                            
"VimFilePrevious                                   
"VimFileSaveClose                                  
"VimFilterCountLines                               
"VimFilterMotion                                   
"VimFilterVisualLines                              
"VimForward                                        
"VimGotoDeclaration                                
"VimInsertAfterCursor                              
"VimInsertAfterLineEnd                             
"VimInsertAtPreviousInsert                         
"VimInsertBeforeCursor                             
"VimInsertBeforeFirstNonBlank                      
"VimInsertCharacterAboveCursor                     
"VimInsertCharacterBelowCursor                     
"VimInsertDeleteInsertedText                       
"VimInsertDeletePreviousWord                       
"VimInsertEnter                                    
"VimInsertExitMode                                 
"VimInsertLineStart                                
"VimInsertNewLineAbove                             
"VimInsertNewLineBelow                             
"VimInsertPreviousInsert                           
"VimInsertPreviousInsertExit                       
"VimInsertRegister                                 
"VimInsertReplaceToggle                            
"VimInsertSingleCommand                            
"VimLastGlobalSearchReplace                        
"VimLastSearchReplace                              
"VimMotionBigWordEndLeft                           
"VimMotionBigWordEndRight                          
"VimMotionBigWordLeft                              
"VimMotionBigWordRight                             
"VimMotionCamelEndLeft                             
"VimMotionCamelEndRight                            
"VimMotionCamelLeft                                
"VimMotionCamelRight                               
"VimMotionColumn                                   
"VimMotionDown                                     
"VimMotionDownFirstNonSpace                        
"VimMotionDownLess1FirstNonSpace                   
"VimMotionFirstColumn                              
"VimMotionFirstNonSpace                            
"VimMotionFirstScreenColumn                        
"VimMotionFirstScreenLine                          
"VimMotionFirstScreenNonSpace                      
"VimMotionGotoFileMark                             
"VimMotionGotoFileMarkLine                         
"VimMotionGotoLineFirst                            
"VimMotionGotoLineLast                             
"VimMotionGotoLineLastEnd                          
"VimMotionGotoMark                                 
"VimMotionGotoMarkLine                             
"VimMotionInnerBlockAngle                          
"VimMotionInnerBlockBackQuote                      
"VimMotionInnerBlockBrace                          
"VimMotionInnerBlockBracket                        
"VimMotionInnerBlockDoubleQuote                    
"VimMotionInnerBlockParen                          
"VimMotionInnerBlockSingleQuote                    
"VimMotionInnerBlockTag                            
"VimMotionInnerParagraph                           
"VimMotionInnerSentence                            
"VimMotionJumpNext                                 
"VimMotionJumpPrevious                             
"VimMotionLastColumn                               
"VimMotionLastMatchChar                            
"VimMotionLastMatchCharReverse                     
"VimMotionLastNonSpace                             
"VimMotionLastScreenColumn                         
"VimMotionLastScreenLine                           
"VimMotionLeft                                     
"VimMotionLeftMatchChar                            
"VimMotionLeftTillMatchChar                        
"VimMotionLeftWrap                                 
"VimMotionMark                                     
"VimMotionMethodBackwardEnd                        
"VimMotionMethodBackwardStart                      
"VimMotionMethodForwardEnd                         
"VimMotionMethodForwardStart                       
"VimMotionMiddleColumn                             
"VimMotionMiddleScreenLine                         
"VimMotionNextTab                                  
"VimMotionNthCharacter                             
"VimMotionOuterBlockAngle                          
"VimMotionOuterBlockBackQuote                      
"VimMotionOuterBlockBrace                          
"VimMotionOuterBlockBracket                        
"VimMotionOuterBlockDoubleQuote                    
"VimMotionOuterBlockParen                          
"VimMotionOuterBlockSingleQuote                    
"VimMotionOuterBlockTag                            
"VimMotionOuterParagraph                           
"VimMotionOuterSentence                            
"VimMotionParagraphNext                            
"VimMotionParagraphPrevious                        
"VimMotionPercentOrMatch                           
"VimMotionPreviousTab                              
"VimMotionRight                                    
"VimMotionRightMatchChar                           
"VimMotionRightTillMatchChar                       
"VimMotionRightWrap                                
"VimMotionScrollColumnLeft                         
"VimMotionScrollColumnRight                        
"VimMotionScrollFirstScreenColumn                  
"VimMotionScrollFirstScreenLine                    
"VimMotionScrollFirstScreenLinePageStart           
"VimMotionScrollFirstScreenLineStart               
"VimMotionScrollHalfPageDown                       
"VimMotionScrollHalfPageUp                         
"VimMotionScrollLastScreenColumn                   
"VimMotionScrollLastScreenLine                     
"VimMotionScrollLastScreenLinePageStart            
"VimMotionScrollLastScreenLineStart                
"VimMotionScrollLineDown                           
"VimMotionScrollLineUp                             
"VimMotionScrollMiddleScreenLine                   
"VimMotionScrollMiddleScreenLineStart              
"VimMotionScrollPageDown                           
"VimMotionScrollPageUp                             
"VimMotionSectionBackwardEnd                       
"VimMotionSectionBackwardStart                     
"VimMotionSectionForwardEnd                        
"VimMotionSectionForwardStart                      
"VimMotionSentenceEndNext                          
"VimMotionSentenceEndPrevious                      
"VimMotionSentenceStartNext                        
"VimMotionSentenceStartPrevious                    
"VimMotionTextInnerBigWord                         
"VimMotionTextInnerWord                            
"VimMotionTextOuterBigWord                         
"VimMotionTextOuterWord                            
"VimMotionUnmatchedBraceClose                      
"VimMotionUnmatchedBraceOpen                       
"VimMotionUnmatchedParenClose                      
"VimMotionUnmatchedParenOpen                       
"VimMotionUp                                       
"VimMotionUpFirstNonSpace                          
"VimMotionWordEndLeft                              
"VimMotionWordEndRight                             
"VimMotionWordLeft                                 
"VimMotionWordRight                                
"VimOperatorAction                                 
"VimPlaybackLastRegister                           
"VimPlaybackRegister                               
"VimPluginToggle                                    <M-A-V>
"VimProcessExEntry                                 
"VimProcessExKey                                   
"VimRedo                                           
"VimReformatVisual                                 
"VimRepeatChange                                   
"VimRepeatExCommand                                
"VimResetMode                                      
"VimSearchAgainNext                                
"VimSearchAgainPrevious                            
"VimSearchFwdEntry                                 
"VimSearchRevEntry                                 
"VimSearchWholeWordBackward                        
"VimSearchWholeWordForward                         
"VimSearchWordBackward                             
"VimSearchWordForward                              
"VimShiftLeftLines                                 
"VimShiftLeftMotion                                
"VimShiftLeftVisual                                
"VimShiftRightLines                                
"VimShiftRightMotion                               
"VimShiftRightVisual                               
"VimShortcutKeyAction                              
"VimToggleRecording                                
"VimUndo                                           
"VimVisualBlockAppend                              
"VimVisualBlockInsert                              
"VimVisualExitMode                                 
"VimVisualPutText                                  
"VimVisualPutTextMoveCursor                        
"VimVisualPutTextNoIndent                          
"VimVisualSelectPrevious                           
"VimVisualSwapEnds                                 
"VimVisualSwapEndsBlock                            
"VimVisualSwapSelections                           
"VimVisualToggleBlockMode                          
"VimVisualToggleCharacterMode                      
"VimVisualToggleLineMode                           
"VimWindowClose                                    
"VimWindowDown                                     
"VimWindowLeft                                     
"VimWindowNext                                     
"VimWindowOnly                                     
"VimWindowPrev                                     
"VimWindowRight                                    
"VimWindowSplitHorizontal                          
"VimWindowSplitVertical                            
"VimWindowUp                                       
"WeighingNewGroup                                  
"WelcomeScreen.ChangeProjectIcon                   
"WelcomeScreen.Configure                           
"WelcomeScreen.Configure.DesktopEntry              
"WelcomeScreen.Configure.Export                    
"WelcomeScreen.Configure.IDEA                      
"WelcomeScreen.Configure.Import                    
"WelcomeScreen.CreateNewProject                    
"WelcomeScreen.DevelopPlugins                      
"WelcomeScreen.Documentation                       
"WelcomeScreen.Documentation.IDEA                  
"WelcomeScreen.EditGroup                           
"WelcomeScreen.GetFromVcs                          
"WelcomeScreen.ImportProject                       
"WelcomeScreen.MoveToGroup                         
"WelcomeScreen.NewGroup                            
"WelcomeScreen.OpenProject                         
"WelcomeScreen.OpenSelected                        
"WelcomeScreen.Plugins                             
"WelcomeScreen.QuickStart                          
"WelcomeScreen.QuickStart.IDEA                     
"WelcomeScreen.RemoveSelected                      
"WelcomeScreen.Settings                            
"WelcomeScreen.Update                              
"WelcomeScreenRecentProjectActionGroup             
"WhatsNewAction                                    
"WindowMenu                                        
"working.context                                   
"WrapReturnValue                                   
"XDebugger.Actions                                 
"XDebugger.AttachGroup                             
"XDebugger.AttachToLocalProcess                    
"XDebugger.CompareValueWithClipboard               
"XDebugger.CopyName                                
"XDebugger.CopyValue                                <M-C>
"XDebugger.CopyWatch                                <M-D>
"XDebugger.EditWatch                                <F2>
"XDebugger.Evaluation.Dialog.Tree.Popup            
"XDebugger.Frames.TopToolbar                       
"XDebugger.Frames.Tree.Popup                       
"XDebugger.Inline                                  
"XDebugger.Inspect                                 
"XDebugger.Inspect.Tree.Popup                      
"XDebugger.JumpToSource                             <M-Down> <F4>
"XDebugger.JumpToTypeSource                         <S-F4>
"XDebugger.MoveWatchDown                            <C-Down>
"XDebugger.MoveWatchUp                              <C-Up>
"XDebugger.MuteBreakpoints                         
"XDebugger.NewWatch                                
"XDebugger.RemoveAllWatches                        
"XDebugger.RemoveWatch                              <Del> <BS> <M-BS>
"XDebugger.Settings                                
"XDebugger.SetValue                                 <F2>
"XDebugger.SwitchWatchesInVariables                
"XDebugger.ToggleSortValues                        
"XDebugger.ToolWindow.LeftToolbar                  
"XDebugger.ToolWindow.TopToolbar                   
"XDebugger.UnmuteOnStop                            
"XDebugger.ValueGroup                              
"XDebugger.Variables.Tree.Popup                    
"XDebugger.Variables.Tree.Toolbar                  
"XDebugger.Watches.Tree.Popup                      
"XDebugger.Watches.Tree.Toolbar                    
"XmlGenerateToolsGroup                             
"XPathView.Actions.Evaluate                         <M-A-X>
"XPathView.Actions.FindByExpression                 <M-A-X>
"XPathView.Actions.ShowPath                         <M-A-X>
"XPathView.EditorPopup                             
"XPathView.MainMenu.Search                         
"XPathView.XSLT.Associations                       
"XSD2Document                                      
"ZoomCurrentWindow                                  <M-C-=>