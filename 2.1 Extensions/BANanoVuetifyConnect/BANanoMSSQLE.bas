﻿B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Private recType As Map
	Public const DB_VARCHAR_20 As String = "VARCHAR(20)"
	Public const DB_VARCHAR_10 As String = "VARCHAR(10)"
	Public const DB_VARCHAR_30 As String = "VARCHAR(30)"
	Public const DB_VARCHAR_40 As String = "VARCHAR(40)"
	Public const DB_VARCHAR_50 As String = "VARCHAR(50)"
	Public const DB_VARCHAR_100 As String = "VARCHAR(100)"
	Public const DB_VARCHAR_255 As String = "VARCHAR(255)"
	Public const DB_STRING As String = "TEXT"
	Public const DB_INT As String = "INT"
	Public const DB_FLOAT As String = "FLOAT"
	Public const DB_BLOB As String = "BLOB"
	Public const DB_BOOL As String = "BOOL"
	Public const DB_REAL As String = "REAL"
	Public const DB_DATE As String = "DATE"
	Public const DB_INTEGER As String = "INTEGER"
	Public const DB_TEXT As String = "TEXT"
	Private BANano As BANano   'ignore
	Public MethodName As String
	Public MethodNameDynamic As String
	Private Schema As Map
	Public TableName As String
	Public PrimaryKey As String
	Public Record As Map
	Public OK As Boolean
	Public DBase As String
	Public result As List
	Public command As String
	Public types As List
	Public args As List
	Public query As String
	Public response As String
	Public error As String
	Public affectedRows As Long
	Public json As String
	Private Schema As Map
	Private host As String
	Private username As String
	Private password As String
	Private Auto As String
End Sub

'set database connection settings
Sub SetConnection(shost As String, susername As String, spassword As String) As BANanoMSSQLE
	host = shost
	username = susername
	password = spassword
	Return Me
End Sub


Sub AndOrOperators(sm As Map) As List    'ignore
	Dim nl As List
	nl.initialize
	For Each k As String In sm.Keys
		nl.Add("AND")
	Next
	Return nl
End Sub

'return a sql to select record of table where one exists
Sub SelectWhere1(tblfields As List, tblWhere As Map, operators As List, AndOr As List, orderBy As List) As BANanoMSSQLE
	If operators = Null Then operators = EQOperators(tblWhere)
	If AndOr = Null Then AndOr = AndOrOperators(tblWhere)
	Dim listOfTypes As List = GetMapTypes(tblWhere)
	Dim listOfValues As List = GetMapValues(tblWhere)
	'are we selecting all fields or just some
	Dim fld1 As String = tblfields.Get(0)
	Dim selFIelds As String = ""
	Select Case fld1
		Case "*"
			selFIelds = "*"
		Case Else
			selFIelds = JoinFields(",", tblfields)
	End Select
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"SELECT ${selFIelds} FROM ${EscapeField(TableName)} WHERE "$)
	Dim i As Int
	Dim iWhere As Int = tblWhere.Size - 1
	For i = 0 To iWhere
		If i > 0 Then
			Dim sandor As String = AndOr.get(i)
			sb.Append($" ${sandor} "$)
		End If
		Dim col As String = tblWhere.GetKeyAt(i)
		sb.Append(col)
		Dim opr As String = operators.Get(i)
		sb.Append($" ${opr} ?"$)
	Next
	If orderBy <> Null Then
		'order by
		Dim stro As String = JoinFields(",", orderBy)
		If stro.Length > 0 Then
			sb.Append(" ORDER BY ").Append(stro)
		End If
	End If
	query = sb.tostring
	args = listOfValues
	types = listOfTypes
	command = "select"
	response = ""
	error = ""
	result = NewList
	json = ""
	affectedRows = 0
	Return Me
End Sub

'get table names
Sub GetTableNames As BANanoMSSQLE
	query = $"select table_name from information_schema.tables where TABLE_TYPE = 'BASE TABLE' and table_name not in ('MSreplication_options','spt_fallback_db', 'spt_fallback_dev', 'spt_fallback_usg', 'spt_monitor') order by table_name"$
	command = "select"
	Return Me
End Sub

'get table structure
Sub GetTableStructure As BANanoMSSQLE
	query = $"select character_maximum_length, column_name, data_type from information_schema.columns where table_name = '${TableName}'"$
	command = "select"
	Return Me
End Sub


Sub NewList As List
	Dim lst As List
	lst.Initialize
	Return lst
End Sub

'convert the json
Sub FromJSON As BANanoMSSQLE
	OK = False
	If json.StartsWith("{") Or json.Startswith("[") Then
		Dim m As Map = BANano.FromJson(json)
		response = m.Get("response")
		error = m.Get("error")
		result = m.Get("result")
		affectedRows = m.Get("affectedRows")
		If response = "Success" Then
			OK = True
		End If
	Else
		response = json
		error = json
		result = NewList
		affectedRows = -1
		OK = False
	End If
	Return Me
End Sub


'return a sql to delete record of table where one exists
Sub DeleteAll As BANanoMSSQLE
	Dim sb As String = $"DELETE FROM ${EscapeField(TableName)}"$
	query = sb
	command = "delete"
	Return Me
End Sub

Sub SchemaAddField(fldName As String, fldType As String)
	Schema.Put(fldName, fldType)
End Sub


Sub SchemaAddBlob(bools As List) As BANanoMSSQLE
	For Each b As String In bools
		Schema.Put(b, DB_BLOB)
	Next
	AddBlobs(bools)
	Return Me
End Sub


'schema add boolean
Sub SchemaAddBoolean(bools As List) As BANanoMSSQLE
	For Each b As String In bools
		Schema.Put(b, DB_BOOL)
	Next
	AddBooleans(bools)
	Return Me
End Sub


Sub SchemaAddDate(bools As List) As BANanoMSSQLE
	For Each b As String In bools
		Schema.Put(b, DB_DATE)
	Next
	AddStrings(bools)
	Return Me
End Sub


Sub SchemaAddFloat(bools As List) As BANanoMSSQLE
	For Each b As String In bools
		Schema.Put(b, DB_FLOAT)
	Next
	AddDoubles(bools)
	Return Me
End Sub

Sub SchemaAddText(bools As List) As BANanoMSSQLE
	For Each b As String In bools
		Schema.Put(b, DB_STRING)
	Next
	AddStrings(bools)
	Return Me
End Sub



Sub SchemaAddInt(bools As List) As BANanoMSSQLE
	For Each b As String In bools
		Schema.Put(b, DB_INT)
	Next
	AddIntegers(bools)
	Return Me
End Sub


Sub Update(priValue As String) As BANanoMSSQLE
	Dim tblWhere As Map = CreateMap()
	tblWhere.Put(PrimaryKey, priValue)
	UpdateWhere(TableName, Record, tblWhere, Null)
	Return Me
End Sub

Sub Update1(Rec As Map, priValue As String) As BANanoMSSQLE
	Record = rec
	Dim tblWhere As Map = CreateMap()
	tblWhere.Put(PrimaryKey, priValue)
	UpdateWhere(TableName, Rec, tblWhere, Null)
	Return Me
End Sub

Sub EQOperators(sm As Map) As List    'ignore
	Dim nl As List
	nl.initialize
	For Each k As String In sm.Keys
		nl.Add("=")
	Next
	Return nl
End Sub

Sub RecordFromMap(sm As Map)
	Record.Initialize
	For Each k As String In sm.Keys
		Dim v As Object = sm.Get(k)
		Record.Put(k, v)
	Next
End Sub

'prepare for new table definition
Sub SchemaClear As BANanoMSSQLE
	Schema.clear
	Return Me
End Sub


Sub SetField(fldName As String, fldValue As Object) As BANanoMSSQLE
	Record.Put(fldName, fldValue)
	Return Me
End Sub

Sub SchemaAddBooleans(bools As List) As BANanoMSSQLE
	SchemaAddBoolean(bools)
	Return Me
End Sub
'

'
Sub SchemaFromDesign(cont As VMContainer) As BANanoMSSQLE
	SchemaAddBoolean(cont.Booleans)
	SchemaAddDate(cont.Dates)
	SchemaAddFloat(cont.Doubles)
	SchemaAddInt(cont.Integers)
	SchemaAddText(cont.Strings)
	'update field types
	AddStrings(cont.Strings)
	AddIntegers(cont.Integers)
	AddDoubles(cont.Doubles)
	AddBooleans(cont.Booleans)
	AddStrings(cont.Dates)
	Return Me
End Sub

Sub SchemaAddIntegers(ints As List) As BANanoMSSQLE
	SchemaAddInt(ints)
	Return Me
End Sub

Sub SchemaAddDoubles(dbls As List) As BANanoMSSQLE
	SchemaAddFloat(dbls)
	Return Me
End Sub


Sub SchemaAddBlobs(blobs As List) As BANanoMSSQLE
	SchemaAddBlob(blobs)
	Return Me
End Sub


Sub SchemaAddStrings(strings As List) As BANanoMSSQLE
	SchemaAddText(strings)
	Return Me
End Sub



Sub SchemaCreateTable As BANanoMSSQLE
	Return CreateTable(Schema)
End Sub


Sub SchemaAddDates(dates As List) As BANanoMSSQLE
	SchemaAddDate(dates)
	Return Me
End Sub


'return a sql command to create the table
public Sub CreateTable(tblFields As Map) As BANanoMSSQLE
	Dim fldName As String
	Dim fldType As String
	Dim fldTot As Int
	Dim fldCnt As Int
	fldTot = tblFields.Size - 1
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("(")
	For fldCnt = 0 To fldTot
		fldName = tblFields.GetKeyAt(fldCnt)
		fldType = tblFields.Get(fldName)
		fldType = fldType.Replace("STRING", "TEXT")
		fldType = fldType.Replace("TEXT", "VARCHAR(255)")
		If fldCnt > 0 Then
			sb.Append(", ")
		End If
		sb.Append(EscapeField(fldName))
		sb.Append(" ")
		sb.Append(fldType)
		If fldName.EqualsIgnoreCase(Auto) Then
			sb.Append(" IDENTITY(1,1)")
		End If
		If fldName.EqualsIgnoreCase(PrimaryKey) Then
			sb.Append(" PRIMARY KEY")
		End If
	Next
	sb.Append(")")
	'define the qry to execute
	query = "CREATE TABLE " & EscapeField(TableName) & " " & sb.ToString
	command = "createtable"
	Return Me
End Sub

'used when creating a new query
Sub ResetTypes As BANanoMSSQLE
	recType.Initialize
	Return Me
End Sub

'return a sql to delete record of table where one exists
Sub GetMax As BANanoMSSQLE
	Dim sb As String = $"SELECT MAX(${PrimaryKey}) As ${PrimaryKey} FROM ${EscapeField(TableName)}"$
	query = sb
	command = "getmax"
	Return Me
End Sub

'return a sql to delete record of table where one exists
Sub GetMin As BANanoMSSQLE
	Dim sb As String = $"SELECT MIN(${PrimaryKey}) As ${PrimaryKey} FROM ${EscapeField(TableName)}"$
	query = sb
	command = "getmin"
	Return Me
End Sub

Sub GetNextID As String
	Dim nextid As Int
	Dim strid As String
	
	If result.Size = 0 Then
		nextid = 0
	Else
		Dim nr As Map = result.Get(0)
		Dim ni As String = nr.GetDefault(PrimaryKey,"0")
		nextid = BANano.parseInt(ni)
	End If
	nextid = nextid + 1
	strid = CStr(nextid)
	nextid = BANano.ParseInt(nextid)
	Return strid
End Sub


'convert object to string
private Sub CStr(o As Object) As String
	If o = BANano.UNDEFINED Then o = ""
	Return "" & o
End Sub

'initialize the class and pass the PHP sub name to call
Sub Initialize(dbName As String, tblName As String, PK As String, AI As String) As BANanoMSSQLE
	recType.Initialize
	Schema.Initialize
	Record.Initialize
	MethodName = "BANanoMSSQL"
	MethodNameDynamic = "BANanoMSSQLDynamic"
	result.Initialize
	command = ""
	PrimaryKey = PK
	DBase = dbName
	TableName = tblName
	types.Initialize
	args.Initialize
	types = Null
	args = Null
	query = ""
	response = ""
	error = ""
	affectedRows = 0
	json = ""
	OK = False
	host = ""
	username = ""
	password = ""
	Auto = AI
	Return Me
End Sub

'convert a json string to a map
private Sub Json2Map(strJSON As String) As Map
	Dim jsonx As BANanoJSONParser
	Dim Map1 As Map
	Map1.Initialize
	Map1.clear
	Try
		If strJSON.length > 0 Then
			jsonx.Initialize(strJSON)
			Map1 = jsonx.NextObject
		End If
		Return Map1
	Catch
		Return Map1
	End Try
End Sub

'convert a map to a json string using BANanoJSONGenerator
private Sub Map2Json(mp As Map) As String
	Dim jsonx As BANanoJSONGenerator
	jsonx.Initialize(mp)
	Return jsonx.ToString
End Sub

'specify strings field types, this is default for all strings
Sub AddStrings(fieldNames As List) As BANanoMSSQLE
	For Each strfld As String In fieldNames
		recType.Put(strfld,"STRING")
	Next
	Return Me
End Sub

'specify integer field types
Sub AddIntegers(fieldNames As List) As BANanoMSSQLE
	For Each strfld As String In fieldNames
		recType.Put(strfld,"INT")
	Next
	Return Me
End Sub

'specify double field types
Sub AddDoubles(fieldNames As List) As BANanoMSSQLE
	For Each strfld As String In fieldNames
		recType.Put(strfld,"DOUBLE")
	Next
	Return Me
End Sub

'specify blob field types
Sub AddBlobs(fieldNames As List) As BANanoMSSQLE
	For Each strfld As String In fieldNames
		recType.Put(strfld,"BLOB")
	Next
	Return Me
End Sub

'specify double field types
Sub AddBooleans(fieldNames As List) As BANanoMSSQLE
	For Each strfld As String In fieldNames
		recType.Put(strfld,"BOOL")
	Next
	Return Me
End Sub


Sub FirstRecord As Map
	Dim rec As Map = result.Get(0)
	Return rec
End Sub

'escape fields with []
Private Sub EscapeField(f As String) As String
	Return $"[${f}]"$
End Sub

'execute own query
Sub Execute(strSQL As String) As BANanoMSSQLE
	strSQL = strSQL.trim
	query = strSQL
	command = "execute"
	Return Me
End Sub


'get the list of types
private Sub GetMapTypes(sourceMap As Map) As List
	Dim listOfTypes As List
	listOfTypes.Initialize
	Dim iCnt As Int
	Dim iTot As Int
	iTot = sourceMap.Size - 1
	For iCnt = 0 To iTot
		Dim col As String = sourceMap.GetKeyAt(iCnt)
		Dim colType As String = recType.GetDefault(col,"STRING")
		Select Case colType
			Case "INTEGER", "INT", "BOOL","BOOLEAN"
				listOfTypes.add("i")
			Case "BLOB"
				listOfTypes.add("b")
			Case "REAL","FLOAT","DOUBLE"
				listOfTypes.add("d")
			Case Else
				listOfTypes.add("s")
		End Select
	Next
	Return listOfTypes
End Sub


private Sub GetMapType(k As String) As String
	If recType.ContainsKey(k) Then
		Dim colType As String = recType.GetDefault(k, "STRING")
		Select Case colType
			Case "INTEGER", "INT", "BOOL","BOOLEAN"
				Return "i"
			Case "BLOB"
				Return "b"
			Case "REAL","FLOAT","DOUBLE"
				Return "d"
			Case Else
				Return "s"
		End Select
	Else
		Return "s"
	End If
End Sub

'get map values
private Sub GetMapValues(sourceMap As Map) As List
	Dim listOfValues As List
	listOfValues.Initialize
	Dim iCnt As Int
	Dim iTot As Int
	iTot = sourceMap.Size - 1
	For iCnt = 0 To iTot
		'get the value
		Dim key As String = sourceMap.getkeyat(iCnt)
		Dim value As String = sourceMap.GetValueAt(iCnt)
		value = CStr(value)
		value = value.trim
		'get the type
		Dim vtype As String = GetMapType(key)
		Select Case vtype
			Case "i"
				'integer
				If value = "" Then value = "0"
				value = BANano.parseInt(value)
			Case "d"
				'double
				If value = "" Then value = "0"
				value = BANano.parsefloat(value)
			Case "s", "b"
				'string
		End Select
		listOfValues.Add(value)
	Next
	Return listOfValues
End Sub

'get map keys
private Sub GetMapKeys(sourceMap As Map) As List
	Dim listOfValues As List
	listOfValues.Initialize
	Dim iCnt As Int
	Dim iTot As Int
	iTot = sourceMap.Size - 1
	For iCnt = 0 To iTot
		Dim value As String = sourceMap.GetKeyAt(iCnt)
		listOfValues.Add(value)
	Next
	Return listOfValues
End Sub


'return a sql insert statement
Sub Insert As BANanoMSSQLE
	Insert1(Record)
	Return Me
End Sub

'return a sql insert statement
Sub Insert1(Rec As Map) As BANanoMSSQLE
	If Schema.Size = 0 Then
		Log($"BANanoMSSQLE.Insert: '${TableName}' schema is not set!"$)
	End If
	Dim sb As StringBuilder
	Dim columns As StringBuilder
	Dim values As StringBuilder
	Dim listOfValues As List = GetMapValues(Rec)
	Dim listOfTypes As List = GetMapTypes(Rec)
	Dim iCnt As Int
	Dim iTot As Int
	sb.Initialize
	columns.Initialize
	values.Initialize
	sb.Append($"INSERT INTO ${EscapeField(TableName)} ("$)
	iTot = Rec.Size - 1
	For iCnt = 0 To iTot
		Dim col As String = Rec.GetKeyAt(iCnt)
		If iCnt > 0 Then
			columns.Append(", ")
			values.Append(", ")
		End If
		columns.Append(EscapeField(col))
		values.Append("?")
	Next
	sb.Append(columns.ToString)
	sb.Append(") VALUES (")
	sb.Append(values.ToString)
	sb.Append(")")
	query = sb.ToString
	args = listOfValues
	types = listOfTypes
	command = "insert"
	Return Me
End Sub


'join list to multi value string
private Sub JoinFields(delimiter As String, lst As List) As String
	Dim i As Int
	Dim sb As StringBuilder
	Dim fld As String
	sb.Initialize
	fld = lst.Get(0)
	fld = EscapeField(fld)
	sb.Append(fld)
	For i = 1 To lst.size - 1
		Dim fld As String = lst.Get(i)
		fld = EscapeField(fld)
		sb.Append(delimiter).Append(fld)
	Next
	Return sb.ToString
End Sub

'join list to mv string
private Sub Join(delimiter As String, lst As List) As String
	Dim i As Int
	Dim sb As StringBuilder
	Dim fld As String
	sb.Initialize
	fld = lst.Get(0)
	sb.Append(fld)
	For i = 1 To lst.size - 1
		Dim fld As String = lst.Get(i)
		sb.Append(delimiter).Append(fld)
	Next
	Return sb.ToString
End Sub


'read
Sub Read(primaryValue As String) As BANanoMSSQLE
	Dim qw As Map = CreateMap()
	qw.Put(PrimaryKey, primaryValue)
	SelectWhere(TableName, Array("*"), qw, Null, Array(PrimaryKey))
	Return Me
End Sub

'delete a single value based on the primary key
Sub Delete(primaryValue As String) As BANanoMSSQLE
	Dim qw As Map = CreateMap()
	qw.Put(PrimaryKey, primaryValue)
	DeleteWhere(TableName, qw, Array("="))
	Return Me
End Sub


'exists
Sub Exists(primaryValue As String) As BANanoMSSQLE
	Dim qw As Map = CreateMap()
	qw.Put(PrimaryKey, primaryValue)
	SelectWhere(TableName, Array(PrimaryKey), qw, Null, Array(PrimaryKey))
	Return Me
End Sub

'return a sql to select record of table where one exists
Sub SelectWhere(tblName As String, tblfields As List, tblWhere As Map, operators As List, orderBy As List) As BANanoMSSQLE
	If Schema.Size = 0 Then
		Log($"BANanoMSSQLE.SelectWhere: '${tblName}' schema is not set!"$)
	End If
	If operators = Null Then operators = EQOperators(tblWhere)
	Dim listOfTypes As List = GetMapTypes(tblWhere)
	Dim listOfValues As List = GetMapValues(tblWhere)
	'are we selecting all fields or just some
	Dim fld1 As String = tblfields.Get(0)
	Dim selFIelds As String = ""
	Select Case fld1
		Case "*"
			selFIelds = "*"
		Case Else
			selFIelds = JoinFields(",", tblfields)
	End Select
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"SELECT ${selFIelds} FROM ${EscapeField(tblName)} WHERE "$)
	Dim i As Int
	Dim iWhere As Int = tblWhere.Size - 1
	For i = 0 To iWhere
		If i > 0 Then
			sb.Append(" AND ")
		End If
		Dim col As String = tblWhere.GetKeyAt(i)
		sb.Append(EscapeField(col))
		Dim opr As String = operators.Get(i)
		sb.Append($" ${opr} ?"$)
	Next
	If orderBy <> Null Then
		'order by
		Dim stro As String = JoinFields(",", orderBy)
		If stro.Length > 0 Then
			sb.Append(" ORDER BY ").Append(stro)
		End If
	End If
	query = sb.tostring
	args = listOfValues
	types = listOfTypes
	command = "select"
	Return Me
End Sub

'return a sql to select record of table where one exists
Sub SelectDistinctWhere(tblName As String, tblfields As List, tblWhere As Map, operators As List, orderBy As List) As BANanoMSSQLE
	If Schema.Size = 0 Then
		Log($"BANanoMSSQLE.SelectWhere: '${tblName}' schema is not set!"$)
	End If
	If operators = Null Then operators = EQOperators(tblWhere)
	Dim listOfTypes As List = GetMapTypes(tblWhere)
	Dim listOfValues As List = GetMapValues(tblWhere)
	'are we selecting all fields or just some
	Dim fld1 As String = tblfields.Get(0)
	Dim selFIelds As String = ""
	Select Case fld1
		Case "*"
			selFIelds = "*"
		Case Else
			selFIelds = JoinFields(",", tblfields)
	End Select
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"SELECT DISTINCT ${selFIelds} FROM ${EscapeField(tblName)} WHERE "$)
	Dim i As Int
	Dim iWhere As Int = tblWhere.Size - 1
	For i = 0 To iWhere
		If i > 0 Then
			sb.Append(" AND ")
		End If
		Dim col As String = tblWhere.GetKeyAt(i)
		Dim oper As String = operators.Get(i)
		sb.Append(EscapeField(col))
		sb.Append($" ${oper} ?"$)
	Next
	If orderBy <> Null Then
		'order by
		Dim stro As String = JoinFields(",", orderBy)
		If stro.Length > 0 Then
			sb.Append(" ORDER BY ").Append(stro)
		End If
	End If
	query = sb.tostring
	args = listOfValues
	types = listOfTypes
	command = "select"
	Return Me
End Sub

'return a sql to delete record of table where one exists
Sub DeleteWhere(tblName As String, tblWhere As Map, operators As List) As BANanoMSSQLE
	If Schema.Size = 0 Then
		Log($"BANanoMSSQLE.DeleteWhere: '${tblName}' schema is not set!"$)
	End If
	If operators = Null Then operators = EQOperators(tblWhere)
	Dim listOfTypes As List = GetMapTypes(tblWhere)
	Dim listOfValues As List = GetMapValues(tblWhere)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"DELETE FROM ${EscapeField(tblName)} WHERE "$)
	Dim i As Int
	Dim iWhere As Int = tblWhere.Size - 1
	For i = 0 To iWhere
		If i > 0 Then
			sb.Append(" AND ")
		End If
		Dim col As String = tblWhere.GetKeyAt(i)
		sb.Append(EscapeField(col))
		Dim opr As String = operators.Get(i)
		sb.Append($" ${opr} ?"$)
	Next
	query = sb.tostring
	args = listOfValues
	types = listOfTypes
	command = "delete"
	Return Me
End Sub


'return a sql to select record of table where one exists
Sub SelectAll(tblfields As List, orderBy As List) As BANanoMSSQLE
	'are we selecting all fields or just some
	Dim fld1 As String = tblfields.Get(0)
	Dim selFIelds As String = ""
	Select Case fld1
		Case "*"
			selFIelds = "*"
		Case Else
			selFIelds = JoinFields(",", tblfields)
	End Select
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"SELECT ${selFIelds} FROM ${EscapeField(TableName)}"$)
	If orderBy <> Null Then
		'order by
		Dim stro As String = JoinFields(",", orderBy)
		If stro.Length > 0 Then
			sb.Append(" ORDER BY ").Append(stro)
		End If
	End If
	query = sb.tostring
	command =  "select"
	Return Me
End Sub

'return a sql to select record of table where one exists
Sub SelectDistinctAll(tblfields As List, orderBy As List) As BANanoMSSQLE
	'are we selecting all fields or just some
	Dim fld1 As String = tblfields.Get(0)
	Dim selFIelds As String = ""
	Select Case fld1
		Case "*"
			selFIelds = "*"
		Case Else
			selFIelds = JoinFields(",", tblfields)
	End Select
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"SELECT DISTINCT ${selFIelds} FROM ${EscapeField(TableName)}"$)
	If orderBy <> Null Then
		'order by
		Dim stro As String = JoinFields(",", orderBy)
		If stro.Length > 0 Then
			sb.Append(" ORDER BY ").Append(stro)
		End If
	End If
	query = sb.tostring
	command =  "select"
	Return Me
End Sub

'build the map to pass to php from statement
Sub Build As Map
	Dim b As Map = CreateMap()
	b.Put("command", command)
	b.Put("query", query)
	b.Put("args", args)
	b.Put("types", types)
	Return b
End Sub

'build with connection settings
Sub BuildDynamic As Map
	Dim b As Map = CreateMap()
	b.Put("command", command)
	b.Put("query", query)
	b.Put("args", args)
	b.Put("types", types)
	b.put("host", host)
	b.Put("username", username)
	b.Put("password", password)
	b.Put("dbname", DBase)
	Return b
End Sub

'return a sql to update records of table where one exists
Sub UpdateWhere(tblName As String, tblfields As Map, tblWhere As Map, operators As List) As BANanoMSSQLE
	If Schema.Size = 0 Then
		Log($"BANanoMSSQLE.UpdateWhere: '${tblName}' schema is not set!"$)
	End If
	If operators = Null Then operators = EQOperators(tblWhere)
	Dim listOfTypes As List = GetMapTypes(tblfields)
	Dim listOfTypes1 As List = GetMapTypes(tblWhere)
	listOfTypes.AddAll(listOfTypes1)
	Dim listOfValues As List = GetMapValues(tblfields)
	Dim listOfValues1 As List = GetMapValues(tblWhere)
	listOfValues.AddAll(listOfValues1)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"UPDATE ${EscapeField(tblName)} SET "$)
	Dim i As Int
	Dim iTot As Int = tblfields.Size - 1
	For i = 0 To iTot
		Dim col As String = tblfields.GetKeyAt(i)
		sb.Append(EscapeField(col))
		If i <> iTot Then
			sb.Append("= ?,")
		Else
			sb.Append("= ?")
		End If
	Next
	sb.Append($" WHERE "$)
	Dim iWhere As Int = tblWhere.Size - 1
	For i = 0 To iWhere
		If i > 0 Then
			sb.Append(" AND ")
		End If
		Dim col As String = tblWhere.GetKeyAt(i)
		sb.Append(EscapeField(col))
		Dim opr As String = operators.Get(i)
		sb.Append($" ${opr} ?"$)
	Next
	query = sb.tostring
	args = listOfValues
	types = listOfTypes
	command = "update"
	Return Me
End Sub


'return a sql to update all records of table
Sub UpdateAll(tblFields As Map,operators As List) As BANanoMSSQLE
	If operators = Null Then operators = EQOperators(tblFields)
	Dim listOfTypes As List = GetMapTypes(tblFields)
	Dim listOfValues As List = GetMapValues(tblFields)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"UPDATE ${EscapeField(TableName)} SET "$)
	Dim i As Int
	Dim iTot As Int = tblFields.Size - 1
	For i = 0 To iTot
		Dim col As String = tblFields.GetKeyAt(i)
		Dim oper As String = operators.Get(i)
		sb.Append(col)
		If i <> iTot Then
			sb.Append(" = ?,")
		Else
			sb.Append($" ${oper} ?"$)
		End If
	Next
	query = sb.tostring
	args = listOfValues
	types = listOfTypes
	command = "update"
	Return Me
End Sub

#if php
function BANanoMSSQL($command, $query, $args, $types){
	$resp = array();
	header('Access-Control-Allow-Origin: *');
	header('content-type: application/json; charset=utf-8');
	require_once './assets/config.php';
	$serverName = DB_HOST;
	$uid = DB_USER;
	$pwd = DB_PASS;
	$database = DB_NAME;
	try {
		$conn = new PDO("sqlsrv:server=$serverName;database=$database", $uid, $pwd);
 		$conn->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
		$conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
		$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
		$conn->setAttribute(PDO::SQLSRV_ATTR_DIRECT_QUERY, true);
		
    	$commands = array('delete', 'update', 'replace', 'insert', 'connection', 'createdb', 'dropdb', 'createtable', 'droptable');
    	if (in_array($command, $commands)) {
        	$command = 'changes';
    	}
		switch ($command) {
    	case "changes":
        	$stmt = $conn->prepare($query);
			$stmt->execute($args);
			$affRows = $stmt->rowCount();
			
			$resp['response'] = "Success";
			$resp['error'] = '';
			$resp['result'] = array();
			$resp['affectedRows'] = $affRows;
			$output = json_encode($resp);
        	break;
    	default:
			$stmt = $conn->prepare($query);
			$stmt->execute($args);
			$rows = $stmt->fetchAll();
        	$affRows = $stmt->rowCount();
			$resp['response'] = "Success";
			$resp['error'] = '';
			$resp['result'] = $rows;
			$resp['affectedRows'] = $affRows;
			$output = json_encode($resp);
        	break;
		}
    	echo ($output);
		// Free statement and connection resources.
		$stmt = null;
		$conn = null;
	} catch( PDOException $e ) {
		$response = $e->getMessage();
		$resp['response'] = "Error";
		$resp['error'] = $response;
		$resp['result'] = array();
		$output = json_encode($resp);
        die($output);
	}
}

function BANanoMSSQLDynamic($command, $query, $args, $types, $host, $username, $password, $dbname){
	$resp = array();
	header('Access-Control-Allow-Origin: *');
	header('content-type: application/json; charset=utf-8');
	$conn=null;
	try {
		$conn = new PDO("sqlsrv:server=$host;database=$dbname", $username, $password);
 		$conn->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
		$conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
		$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
		$conn->setAttribute(PDO::SQLSRV_ATTR_DIRECT_QUERY, true);
		
    	$commands = array('delete', 'update', 'replace', 'insert', 'connection', 'createdb', 'dropdb', 'createtable', 'droptable');
    	if (in_array($command, $commands)) {
        	$command = 'changes';
    	}
		switch ($command) {
    	case "changes":
        	$stmt = $conn->prepare($query);
			$stmt->execute($args);
			$affRows = $stmt->rowCount();
			
			$resp['response'] = "Success";
			$resp['error'] = '';
			$resp['result'] = array();
			$resp['affectedRows'] = $affRows;
			$output = json_encode($resp);
        	break;
    	default:
			$stmt = $conn->prepare($query);
			$stmt->execute($args);
			$rows = $stmt->fetchAll();
        	$affRows = $stmt->rowCount();
			$resp['response'] = "Success";
			$resp['error'] = '';
			$resp['result'] = $rows;
			$resp['affectedRows'] = $affRows;
			$output = json_encode($resp);
        	break;
		}
    	echo ($output);
		// Free statement and connection resources.
		$stmt = null;
		$conn = null;
	} catch( PDOException $e ) {
		$response = $e->getMessage();
		$resp['response'] = "Error";
		$resp['error'] = $response;
		$resp['result'] = array();
		$output = json_encode($resp);
        die($output);
	}
}

#End If