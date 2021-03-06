﻿B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Private contentInt As Map
	Private contents As List
	Public style As PDFStyle
End Sub

'Initializes the stack: a collection of paragraphs
Public Sub Initialize As PDFParagraphs
	contentInt.Initialize
	contents.Initialize
	style.Initialize 
	Return Me
End Sub

'set absolute position
Sub SetAbsolutePosition(x As Int, y As Int) As PDFParagraphs
	Dim opt As Map = CreateMap()
	opt.Put("x", x)
	opt.Put("y", y)
	contentInt.Put("absolutePosition", opt)
	Return Me
End Sub

'add pdf text
Sub AddText(txt As PDFText) As PDFParagraphs
	contents.Add(txt.Content)
	Return Me
End Sub

'add normal text
Sub AddString(txt As String) As PDFParagraphs
	contents.Add(txt)
	Return Me
End Sub


'set page break before
Sub SetPageBreakBefore As PDFParagraphs
	contentInt.Put("pageBreak", "before")
	Return Me
End Sub

'set page break after
Sub SetPageBreakAfter As PDFParagraphs
	contentInt.Put("pageBreak", "after")
	Return Me
End Sub

'get the contents of the stack
Sub getContent As Map
	contentInt.Put("text", contents)
	style.Include(contentInt)
	Return contentInt
End Sub