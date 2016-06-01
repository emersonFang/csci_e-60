<!-- Specify the key name and table name --->

<cfparam name="Form.subjectid" default="" type="string">
<cfparam name="Form.streetnumber" default="lalala" type="string">
<cfparam name="Form.streetname" default="123578" type="string">
<cfparam name="Form.city" default="123453" type="string">
<cfparam name="Form.state" default="1321324" type="string">
<cfparam name="Form.zip" default="dfasfasf" type="string">
<cfparam name="Form.addresstype" default="123432" type="string">

<cfset Key="addressno">
<cfset Table="tbsubject_address">

<!--- Begin the loop --->
<cfset try=0>
<cfloop condition="try lt 4">
<cfset try=try+1>
<cfset Qstring="?subjectid=#Form.subjectid#">

<cftry>
<cftransaction>
<cfset Qerr=0>
<!--- (no error yet) --->

<!--- Get next ID for single-element key --->
<cfquery name="getMax1" 
			datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#">
select max(#Key#) as Max1
from #Table#
where #Table#.subjectid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR"
      value="#Form.subjectid#">
</cfquery>

<cfif len(getMax1.Max1)>
  <cfset ID1=getMax1.Max1+1>
<cfelse>
  <cfset ID1=1>
</cfif>

<!--- Try to add the row --->
<cfquery name="addPhone" 
			datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#">
insert into tbsubject_address (subjectid, addressno, streetnumber, streetname, city, state, zip, addresstype)
values (<cfoutput>'#Form.subjectid#', '#ID1#', '#Form.streetnumber#', '#Form.streetname#', '#Form.city#', '#Form.state#', '#Form.zip#', '#Form.addresstype#'</cfoutput>)
</cfquery>

</cftransaction>

<!--- Exit here when OK --->
<cfbreak>

<!--- Retry up to max times --->
<cfcatch type="database">
<cfif try gt 3>
  <cfset Qstring="?Problem=Repeatedly failed to insert into #Table#; please notify the developer.">
  <cfbreak>
</cfif>
</cfcatch>
</cftry>
</cfloop>

<cfif try EQ 1>
<cfinclude template = "../generalfp.css"></cfinclude>
	<h4>Update Successful!</h4>
	<h4>Added:</h4> <cfoutput>SubjectID: #Form.subjectid#, Address No: #ID1#, Streetnumber: #Form.streetnumber#, Streetname: #Form.streetname#, City: #Form.city#, State: #Form.state#, Zip: #Form.zip#, Addresstype: #Form.addresstype#<br /></cfoutput>
	<p>
	</p>
	<cfform name="return" action="addressform.cfm" method="post">
	<input type="hidden" name="subjectid" value=<cfoutput>"#Form.subjectid#"</cfoutput>/>
	<input type="submit" name="confirm" value="OK" />
	</cfform>
<cfelse>
<cfset myURL="#Asker##Qstring#">
<cflocation url="#myURL#">
</cfif>