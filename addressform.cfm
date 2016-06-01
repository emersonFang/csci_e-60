<head>
    <title>Change Data:</title>
    <cfinclude template = "../generalfp.css">
  </head>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">


<cfparam name="Form.subjectid" default="" type="string">
<cfparam name="Form.addressno" default="" type="string">
<cfparam name="Form.streetnumber" default="" type="string">
<cfparam name="Form.streetname" default="" type="string">
<cfparam name="Form.city" default="" type="string">
<cfparam name="Form.state" default="" type="string">
<cfparam name="Form.zip" default="" type="string">
<cfparam name="Form.addresstype" default="" type="string">

    <cfinclude template = "../headerfp.cfm">

<!--- Respond to showsubjectphoner.cfm --->
<cfparam name="Form.editme" default="">
<cfparam name="Form.delme" default="">
<cfparam name="Form.addme" default="do this">
<cfset Asker="addressform.cfm">
<cfparam name="URL.Problem" default="">
<cfoutput>#Problem#</cfoutput><br>
<cfif len(Form.editme)>
  <cfset myaction="updateaddress.cfm">
  <cfquery name="getsubjectphone"                  
            datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#">
  select * from tbsubject_address
  where subjectid = <cfoutput>#Form.subjectid#</cfoutput> and
  lineno = <cfoutput>#Form.addressno#</cfoutput>
  </cfquery>
  (EDIT): <cfoutput>#Form.editme#</cfoutput><br>
<cfelse>
<cfquery name="getsubjectaddress"
            datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#">
  select * from tbsubject_address
where 1 = 0
</cfquery>
<cfset dummy=QueryAddRow(getsubjectaddress)>
  ADD<br>
  <cfif len(Form.delme)>
    <cfinclude template="deleteaddress.cfm">
    <cfset myaction= "deleteaddress.cfm">
  <cfelseif len(Form.addme)>
    <cfset myaction="insertaddress.cfm">
  </cfif>
</cfif>

<!--- Accept data for insert or update --->
<form name="myForm"
action=<cfoutput>"#myaction#"</cfoutput> method="post">
Street Number: <input type="text" name="streetnumber"
value=<cfoutput>"#getsubjectaddress.streetnumber#"</cfoutput>
size="100" maxlength="100"><br>
Street Name: <input type="text" name="streetname"
value=<cfoutput>"#getsubjectaddress.streetname#"</cfoutput>
size="100" maxlength="100"><br>
City: <input type="text" name="city"
value=<cfoutput>"#getsubjectaddress.city#"</cfoutput>
size="100" maxlength="100"><br>
State: <input type="text" name="state"
value=<cfoutput>"#getsubjectaddress.state#"</cfoutput>
size="100" maxlength="100"><br>
Zip: <input type="text" name="zip"
value=<cfoutput>"#getsubjectaddress.zip#"</cfoutput>
size="100" maxlength="100"><br>
Address Type: <input type="text" name="addresstype"
value=<cfoutput>"#getsubjectaddress.addresstype#"</cfoutput>
size="100" maxlength="100"><br>
<input type="button" name="dothis" value="Exit"
onClick="document.location='homefp.cfm'; return false;">
<input type="reset" name="dummy" value="Reset">
<input type="submit" name="dothis" value="Submit">
<input type="hidden" name="subjectid" value=<cfoutput>"#Form.subjectid#"</cfoutput>>
<input type="hidden" name="addressno" value=<cfoutput>"#Form.addressno#"</cfoutput>>
<input type="hidden" name="Asker" value=<cfoutput>"#Asker#"</cfoutput>>
</form>

</body>
</html>

<!--- Pick for update or delete --->
<hr>
<cfinclude template="showsubjectaddressr.cfm">

<cfinclude template = "../footerfp.cfm">