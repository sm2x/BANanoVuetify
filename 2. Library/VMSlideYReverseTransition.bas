﻿B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
Public SlideYReverseTransition As VMElement
Public ID As String
Private vue As BANanoVue
Private BANano As BANano  'ignore
Private DesignMode As Boolean
Private Module As Object
End Sub

'initialize the SlideYReverseTransition
Public Sub Initialize(v As BANanoVue, sid As String, eventHandler As Object) As VMSlideYReverseTransition
ID = sid.tolowercase
	SlideYReverseTransition.Initialize(v, ID)
	SlideYReverseTransition.SetTag("v-slide-y-reverse-transition")
	DesignMode = False
	Module = eventHandler
	vue = v
	Return Me
End Sub

'get component
Sub ToString As String
Return SlideYReverseTransition.ToString
End Sub

Sub SetVModel(k As String) As VMSlideYReverseTransition
SlideYReverseTransition.SetVModel(k)
Return Me
End Sub

Sub SetVIf(vif As Object) As VMSlideYReverseTransition
SlideYReverseTransition.SetVIf(vif)
Return Me
End Sub

Sub SetVShow(vif As Object) As VMSlideYReverseTransition
SlideYReverseTransition.SetVShow(vif)
Return Me
End Sub

'add to app template
Sub Render
vue.SetTemplate(ToString)
End Sub

'add a child
Sub AddChild(child As VMElement) As VMSlideYReverseTransition
Dim childHTML As String = child.ToString
SlideYReverseTransition.SetText(childHTML)
Return Me
End Sub

'set text
Sub SetText(t As Object) As VMSlideYReverseTransition
SlideYReverseTransition.SetText(t)
Return Me
End Sub

'add to parent
Sub Pop(p As VMElement)
p.SetText(ToString)
End Sub

'add a class
Sub AddClass(c As String) As VMSlideYReverseTransition
SlideYReverseTransition.AddClass(c)
Return Me
End Sub

'set an attribute
Sub SetAttr(attr as map) As VMSlideYReverseTransition
SlideYReverseTransition.SetAttr(attr)
Return Me
End Sub

'set style
Sub SetStyle(sm As Map) As VMSlideYReverseTransition
SlideYReverseTransition.SetStyle(sm)
Return Me
End Sub

'add children
Sub AddChildren(children As List)
For Each childx As VMElement In children
AddChild(childx)
Next
End Sub

'set group
Sub SetGroup(varGroup As Object) As VMSlideYReverseTransition
Dim pp As String = $"${ID}Group"$
vue.SetStateSingle(pp, varGroup)
SlideYReverseTransition.Bind(":group", pp)
Return Me
End Sub

'set hide-on-leave
Sub SetHideOnLeave(varHideOnLeave As Object) As VMSlideYReverseTransition
Dim pp As String = $"${ID}HideOnLeave"$
vue.SetStateSingle(pp, varHideOnLeave)
SlideYReverseTransition.Bind(":hide-on-leave", pp)
Return Me
End Sub

'set leave-absolute
Sub SetLeaveAbsolute(varLeaveAbsolute As Object) As VMSlideYReverseTransition
Dim pp As String = $"${ID}LeaveAbsolute"$
vue.SetStateSingle(pp, varLeaveAbsolute)
SlideYReverseTransition.Bind(":leave-absolute", pp)
Return Me
End Sub

'set mode
Sub SetMode(varMode As Object) As VMSlideYReverseTransition
Dim pp As String = $"${ID}Mode"$
vue.SetStateSingle(pp, varMode)
SlideYReverseTransition.Bind(":mode", pp)
Return Me
End Sub

'set origin
Sub SetOrigin(varOrigin As Object) As VMSlideYReverseTransition
Dim pp As String = $"${ID}Origin"$
vue.SetStateSingle(pp, varOrigin)
SlideYReverseTransition.Bind(":origin", pp)
Return Me
End Sub


'hide the component
Sub Hide As VMSlideYReverseTransition
	SlideYReverseTransition.SetVisible(False)
    Return Me
End Sub

'show the component
Sub Show As VMSlideYReverseTransition
	SlideYReverseTransition.SetVisible(True)
    Return Me
End Sub

'enable the component
Sub Enable As VMSlideYReverseTransition
	SlideYReverseTransition.Enable(True)
    Return Me
End Sub

'disable the component
Sub Disable As VMSlideYReverseTransition
	SlideYReverseTransition.Disable(true)
    Return Me
End Sub


'bind a property to state
Sub Bind(prop As String, stateprop As String) As VMSlideYReverseTransition
	stateprop = stateprop.ToLowerCase
	SetAttrSingle(prop, stateprop)
	Return Me
End Sub

'add a loose attribute without value
Sub SetAttrLoose(loose As String) As VMSlideYReverseTransition
	SlideYReverseTransition.SetAttrLoose(loose)
	Return Me
End Sub

'apply a theme to an element
Sub UseTheme(themeName As String) As VMSlideYReverseTransition
	themeName = themeName.ToLowerCase
	Dim themes As Map = vue.themes
	If themes.ContainsKey(themeName) Then
		Dim sclass As String = themes.Get(themeName)
		AddClass(sclass)
	End If
	Return Me
End Sub


'set color intensity
Sub SetColorIntensity(varColor As String, varIntensity As String) As VMSlideYReverseTransition
	Dim pp As String = $"${ID}Color"$
	Dim scolor As String = $"${varColor} ${varIntensity}"$
	vue.SetStateSingle(pp, scolor)
	SlideYReverseTransition.Bind(":color", pp)
	Return Me
End Sub

'remove an attribute
public Sub RemoveAttr(sName As String) As VMSlideYReverseTransition
	SlideYReverseTransition.RemoveAttr(sName)
	Return Me
End Sub

'set padding
Sub SetPaddingAll(p As String) As VMSlideYReverseTransition
	SlideYReverseTransition.SetPaddingAll(p)
	Return Me
End Sub

'set all margins
Sub SetMarginAll(p As String) As VMSlideYReverseTransition
	SlideYReverseTransition.setmarginall(p)
	Return Me
End Sub

'set design mode
Sub SetDesignMode(b As Boolean) As VMSlideYReverseTransition
	SlideYReverseTransition.SetDesignMode(b)
	DesignMode = b
	Return Me
End Sub

'set tab index
Sub SetTabIndex(ti As String) As VMSlideYReverseTransition
	SlideYReverseTransition.SetTabIndex(ti)
	Return Me
End Sub

'The Select name. Similar To HTML5 name attribute.
Sub SetName(varName As Object, bbind As Boolean) As VMSlideYReverseTransition
	SlideYReverseTransition.SetName(varName, bbind)
	Return Me
End Sub

'set single style
Sub SetStyleSingle(prop As String, value As String) As VMSlideYReverseTransition
	SlideYReverseTransition.SetStyleSingle(prop, value)
	Return Me
End Sub

'set single attribute
Sub SetAttrSingle(prop As String, value As String) As VMSlideYReverseTransition
	SlideYReverseTransition.SetAttrSingle(prop, value)
	Return Me
End Sub

'set single style
Sub BindStyleSingle(prop As String, value As String) As VMSlideYReverseTransition
	SlideYReverseTransition.BindStyleSingle(prop, value)
	Return Me
End Sub

Sub SetVElse(vif As String) As VMSlideYReverseTransition
	SlideYReverseTransition.SetVElse(vif)
	Return Me
End Sub

Sub SetVText(vhtml As String) As VMSlideYReverseTransition
	SlideYReverseTransition.SetVText(vhtml)
	Return Me
End Sub

Sub SetVhtml(vhtml As String) As VMSlideYReverseTransition
	SlideYReverseTransition.SetVHtml(vhtml)
	Return Me
End Sub

Sub SetAttributes(attrs As List) As VMSlideYReverseTransition
	For Each stra As String In attrs
		SetAttrLoose(stra)
	Next
	Return Me
End Sub

'set for
Sub SetVFor(item As String, dataSource As String) As VMSlideYReverseTransition
	dataSource = dataSource.tolowercase
	item = item.tolowercase
	Dim sline As String = $"${item} in ${dataSource}"$
	SetAttrSingle("v-for", sline)
	Return Me
End Sub

Sub SetKey(k As String) As VMSlideYReverseTransition
	k = k.tolowercase
	SetAttrSingle(":key", k)
	Return Me
End Sub

'set the row and column position
Sub SetRC(sRow As String, sCol As String) As VMSlideYReverseTransition
	SlideYReverseTransition.SetRC(sRow, sCol)
	Return Me
End Sub

'set the offsets for this item
Sub SetDeviceOffsets(OS As String, OM As String,OL As String,OX As String) As VMSlideYReverseTransition
	SlideYReverseTransition.SetDeviceOffsets(OS, OM, OL, OX)
	Return Me
End Sub


'set the position: row and column and sizes
Sub SetDevicePositions(srow As String, scell As String, small As String, medium As String, large As String, xlarge As String) As VMSlideYReverseTransition
	SetRC(srow, scell)
	SetDeviceSizes(small,medium, large, xlarge)
	Return Me
End Sub

'set the sizes for this item
Sub SetDeviceSizes(SS As String, SM As String, SL As String, SX As String) As VMSlideYReverseTransition
	SlideYReverseTransition.SetDeviceSizes(SS, SM, SL, SX)
	Return Me
End Sub


Sub AddComponent(comp As String) As VMSlideYReverseTransition
	SlideYReverseTransition.SetText(comp)
	Return Me
End Sub


Sub SetTextCenter As VMSlideYReverseTransition
	SlideYReverseTransition.AddClass("text-center")
	Return Me
End Sub

Sub AddToContainer(pCont As VMContainer, rowPos As Int, colPos As Int)
	pCont.AddComponent(rowPos, colPos, ToString)
End Sub


Sub BuildModel(mprops As Map, mstyles As Map, lclasses As List, loose As List) As VMSlideYReverseTransition
SlideYReverseTransition.BuildModel(mprops, mstyles, lclasses, loose)
Return Me
End Sub


Sub SetVisible(b As Boolean) As VMSlideYReverseTransition
SlideYReverseTransition.SetVisible(b)
Return Me
End Sub


'set color intensity
Sub SetTextColor(varColor As String) As VMSlideYReverseTransition
	Dim sColor As String = $"${varColor}--text"$
	AddClass(sColor)
	Return Me
End Sub

'set color intensity
Sub SetTextColorIntensity(varColor As String, varIntensity As String) As VMSlideYReverseTransition
	Dim sColor As String = $"${varColor}--text"$
	Dim sIntensity As String = $"text--${varIntensity}"$
	Dim mcolor As String = $"${sColor} ${sIntensity}"$
	AddClass(mcolor)
	Return Me
End Sub