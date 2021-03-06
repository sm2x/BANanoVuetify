﻿B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.1
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Public name As String = "prismComponentCode"
	Public title As String = "Prism Component Syntax"
	Private vm As BANanoVM
End Sub


Sub Code
	vm = pgIndex.vm
	'create a container to hold all contents
	Dim cont As VMContainer = vm.CreateContainer(name,Me)
	'hide this container
	cont.Hide
	'create 2 columns each spanning 12 columns
	cont.addrows(1).AddColumns12
	'
	Dim sCode As String = $"var strName ='';"$
	Dim p As VMPrism = vm.CreatePrism("code1", Me).SetLanguage("javascript")
	p.SetCode(sCode)
	cont.AddComponent(1, 1, p.tostring)
	
	vm.AddContainer(cont)
End Sub
