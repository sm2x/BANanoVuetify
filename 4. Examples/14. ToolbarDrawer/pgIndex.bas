﻿B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.1
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private BANano As BANano  'ignore
	Public vm As BANanoVM
End Sub

Sub Init
	'initialize the page
	vm.Initialize(Me, Main.appname)
	BuildNavBar
	BuildNavDrawer
	AddPages
	AddContent
	vm.ux
End Sub

'build the navigation bar
Sub BuildNavBar
	'*copy code after this line
	'add a hamburger
	vm.NavBar.AddHamburger
	vm.NavBar.Hamburger.SetVisible(True)
	'add a logo
	vm.NavBar.Logo.SetBorderRadius("50%")
	vm.NavBar.Logo.SetBorderWidth("1px")
	vm.NavBar.Logo.SetBorderColor("black")
	vm.NavBar.Logo.SetBorderStyle("solid")
	vm.NavBar.Logo.SetSize("46px","46px")
	vm.NavBar.AddLogo("./assets/sponge.png")
	vm.NavBar.Logo.Show
	vm.NavBar.AddTitle("Categories","")
	vm.NavBar.AddSubHeading1("1.00")
	vm.NavBar.AddSpacer
	vm.NavBar.AddSearch("appsearch")
	vm.NavBar.AddSpacer
	vm.NavBar.SetFixed(True)
	vm.NavBar.SetVisible(True)

	vm.NavBar.AddItem("btnAdd", "mdi-plus", "green", "Add Category", "Add a new category", "")
End Sub

'build the nav drawer
Sub BuildNavDrawer
	'*copy code after this line
	vm.Drawer.Setwidth("300")
	vm.Drawer.Setvisible(True)
	vm.setdata("categories", vm.newlist)
	vm.Drawer.SetDataSourceTemplate1("categories","id","","","","name","","","","")

End Sub

'add pages to the app
Sub AddPages
	'*copy code after this line
End Sub

'add content to this page
Sub AddContent
	'*copy code here to add to thos page
End Sub

'*IMPORTANT when a drawer item is clicked
Sub draweritems_click(e As BANanoEvent)
	'get the id from the event
	Dim elID As String = vm.GetIDFromEvent(e)
	Select Case elID
	'copy code below this line
	End Select
End Sub

'confirm dialog ok click
Sub confirm_ok(e As BANanoEvent)
	Dim sconfirm As String = vm.GetConfirm
	Select Case sconfirm
	'copy code below this line
	End Select
End Sub

'confirm dialog cancel click
Sub cancel_ok(e As BANanoEvent)

End Sub

'alert dialog ok clock
Sub alert_ok(e As BANanoEvent)

End Sub

'confirm dialog cancel click
Sub confirm_cancel(e As BANanoEvent)

End Sub


Private Sub btnAdd_click(e As BANanoEvent)
vm.ShowSnackBar("Add Category")
End Sub


'fire when search looses focus
Private Sub appsearch_change(e As BANanoEvent)
'get the search phrase
Dim sappsearch As String = vm.GetData("appsearch")
vm.ShowSnackBar(sappsearch)
End Sub
