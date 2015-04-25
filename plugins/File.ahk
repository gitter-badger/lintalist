/* 
Plugin        : File [Standard Lintalist]
Purpose       : Insert the contents of a file
Version       : 1.0
*/

GetSnippetFile:
 	 Loop ; get Text from File
		{
         If (InStr(Clip, "[[File=") = 0) or (A_Index > 100)
            Break
		 FileRead, PluginSnippetFile, %PluginOptions%
		 StringReplace, clip, clip, %PluginText%, %PluginSnippetFile%, All
		 PluginSnippetFile:=""
		 PluginOptions:=""
		 PluginText:=""
		 ProcessTextString:=""
		}
Return