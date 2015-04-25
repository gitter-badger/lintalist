﻿/* 
Plugin        : Split [Standard Lintalist]
Purpose       : Split input into variables
Version       : 1.0
*/

GetSnippetSplit:
	 Loop 
		{
		 If (InStr(Clip, "[[Split=") = 0) or (A_Index > 100)
			Break
		 sp:={}
		 StringReplace, clip, clip, %PluginText%`n, , All
		 StringReplace, clip, clip, %PluginText%, , All
		 spwhat:=StrSplit(PluginOptions,"|").1
		 If (spwhat = "clipboard")
			spwhat:=ClipSet("g",1,SendMethod) ; restore
		 else If (spwhat = "selected")
			{
			 ClipSet("s",1,SendMethod) ; safe current content and clear clipboard
			 ClearClipboard()
			 SendKey(SendMethod, "^c")
			 spwhat:=clipboard
			 ClearClipboard()
			 Clipboard:=ClipSet("g",1,SendMethod) ; restore
			}
		 If CountString(PluginOptions,"|") > 1 ; multi
			{
			 sprow:=SplitDelimiter(StrSplit(PluginOptions,"|").2)
			 spcol:=SplitDelimiter(StrSplit(PluginOptions,"|").3)
			 ;msgbox % sprow ":" spcol ":" StrSplit(PluginOptions,"|").1
			 Loop, parse, % spwhat, % sprow
				sp.insert(StrSplit(A_LoopField,spcol,"`r"))
			 for k, v in sp
				{
				 row:=k
				 for column,cell in v ; msgbox % row "," a_index
				 	{
					 StringReplace, clip, clip, % "[[sp=" row "," A_Index "]]", % cell, All
					} 
				}
			}
		 else ; single
			{
			 sp:=StrSplit(spwhat,SplitDelimiter(StrSplit(PluginOptions,"|").2),"`r")
			 for k, v in sp
				StringReplace, clip, clip, [[sp=%k%]], %v%, All
			}
		 clip:=RegExReplace(clip,"iU)\[\[sp=.*\]\]") ; remove any stray [[sp=?]]
		 sp:=""
		 row:=""
		 sprow:=""
		 spcol:=""
		 spwhat:=""
		 PluginOptions:=""
		 PluginText:=""
		 ProcessTextString:=""
		}
Return

SplitDelimiter(delim)
	{
	 If (delim = "\n")
		delim:="`n"
	 else If (delim = "\p")
		delim:="|"
	 else If (delim = "\t")
		delim:=A_Tab
	 else If (delim = "\s")
		delim:=A_Space
	 else If (delim = " ")
		delim:=" "
	 else
	 	delim:=delim
	 Return delim 
	}
	
