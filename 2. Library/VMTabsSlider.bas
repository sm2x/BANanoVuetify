﻿B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public TabsSlider As VMElement
	Public ID As String
	Private vue As BANanoVue
	Private BANano As BANano  'ignore
	Private DesignMode As Boolean   'ignore
	Private Module As Object    'ignore
End Sub

'initialize the TabsSlider
Public Sub Initialize(v As BANanoVue, sid As String, eventHandler As Object) As VMTabsSlider
	ID = sid.tolowercase
	TabsSlider.Initialize(v, ID)
	TabsSlider.SetTag("v-tabs-slider")
	DesignMode = False
	Module = eventHandler
	vue = v
	Return Me
End Sub



'add an element to the page content
Sub AddElement(elm As VMElement)
	TabsSlider.SetText(elm.ToString)
End Sub

Sub AddComponent(comp As String) As VMTabsSlider
	TabsSlider.SetText(comp)
	Return Me
End Sub

Sub SetAttrLoose(loose As String) As VMTabsSlider
	TabsSlider.SetAttrLoose(loose)
	Return Me
End Sub

Sub SetAttributes(attrs As List) As VMTabsSlider
	For Each stra As String In attrs
		SetAttrLoose(stra)
	Next
	Return Me
End Sub

Sub SetData(xprop As String, xValue As Object) As VMTabsSlider
	vue.SetData(xprop, xValue)
	Return Me
End Sub



'get component
Sub ToString As String
	
	Return TabsSlider.ToString
End Sub

Sub SetVModel(k As String) As VMTabsSlider
	TabsSlider.SetVModel(k)
	Return Me
End Sub

Sub SetVIf(vif As String) As VMTabsSlider
	TabsSlider.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As String) As VMTabsSlider
	TabsSlider.SetVShow(vif)
	Return Me
End Sub

'add to app template
Sub Render
	vue.SetTemplate(ToString)
End Sub

'add a child
Sub AddChild(child As VMElement) As VMTabsSlider
	Dim childHTML As String = child.ToString
	TabsSlider.SetText(childHTML)
	Return Me
End Sub

'set text
Sub SetText(t As Object) As VMTabsSlider
	TabsSlider.SetText(t)
	Return Me
End Sub

'add to parent
Sub Pop(p As VMElement)
	p.SetText(ToString)
End Sub

'add a class
Sub AddClass(c As String) As VMTabsSlider
	TabsSlider.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr as map) As VMTabsSlider
	TabsSlider.SetAttr(attr)
	Return Me
End Sub

'set style
Sub SetStyle(sm As Map) As VMTabsSlider
	TabsSlider.SetStyle(sm)
	Return Me
End Sub

'add children
Sub AddChildren(children As List)
	For Each childx As VMElement In children
		AddChild(childx)
	Next
End Sub

'set color
Sub SetColor(varColor As Object) As VMTabsSlider
	Dim pp As String = $"${ID}Color"$
	vue.SetStateSingle(pp, varColor)
	TabsSlider.Bind(":color", pp)
	Return Me
End Sub


Sub Hide As VMTabsSlider
	TabsSlider.SetVisible(False)
	Return Me
End Sub

Sub Show As VMTabsSlider
	TabsSlider.SetVisible(True)
	Return Me
End Sub

Sub Enable As VMTabsSlider
	TabsSlider.Enable(True)
	Return Me
End Sub

Sub Disable As VMTabsSlider
	TabsSlider.Disable(True)
	Return Me
End Sub


'bind a property to state
Sub Bind(prop As String, stateprop As String) As VMTabsSlider
	stateprop = stateprop.ToLowerCase
	SetAttrSingle(prop, stateprop)
	Return Me
End Sub


public Sub RemoveAttr(sName As String) As VMTabsSlider
	TabsSlider.RemoveAttr(sName)
	Return Me
End Sub

'set padding
Sub SetPaddingAll(p As String) As VMTabsSlider
	TabsSlider.SetPaddingAll(p)
	Return Me
End Sub

Sub SetMarginAll(p As String) As VMTabsSlider
	TabsSlider.setmarginall(p)
	Return Me
End Sub

Sub SetDesignMode(b As Boolean) As VMTabsSlider
	TabsSlider.SetDesignMode(b)
	DesignMode = b
	Return Me
End Sub

Sub SetTabIndex(ti As String) As VMTabsSlider
	TabsSlider.SetTabIndex(ti)
	Return Me
End Sub

'The Select name. Similar To HTML5 name attribute.
Sub SetName(varName As Object, bbind As Boolean) As VMTabsSlider
	TabsSlider.SetName(varName, bbind)
	Return Me
End Sub


Sub SetStyleSingle(prop As String, value As String) As VMTabsSlider
	TabsSlider.SetStyleSingle(prop, value)
	Return Me
End Sub

Sub SetAttrSingle(prop As String, value As String) As VMTabsSlider
	TabsSlider.SetAttrSingle(prop, value)
	Return Me
End Sub

Sub BuildModel(mprops As Map, mstyles As Map, lclasses As List, loose As List) As VMTabsSlider
TabsSlider.BuildModel(mprops, mstyles, lclasses, loose)
Return Me
End Sub
Sub SetVisible(b As Boolean) As VMTabsSlider
TabsSlider.SetVisible(b)
Return Me
End Sub

'set color intensity
Sub SetTextColor(varColor As String) As VMTabsSlider
	Dim sColor As String = $"${varColor}--text"$
	AddClass(sColor)
	Return Me
End Sub

'set color intensity
Sub SetTextColorIntensity(varColor As String, varIntensity As String) As VMTabsSlider
	Dim sColor As String = $"${varColor}--text"$
	Dim sIntensity As String = $"text--${varIntensity}"$
	Dim mcolor As String = $"${sColor} ${sIntensity}"$
	AddClass(mcolor)
	Return Me
End Sub