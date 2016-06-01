<!--- Respond to showmeasurements.cfm --->
<cfparam name="Form.editme" default="">
<cfparam name="Form.delme" default="">
<cfparam name="Form.addme" default="do this">
<cfset Asker="measurementform.cfm">
<cfparam name="URL.Problem" default="">
<cfoutput>#Problem#</cfoutput><br>
<cfif len(Form.editme)>
  <cfset myaction="update.cfm">
  <cfquery name="getItem" datasource="context">
  select * from Item
  where ItemID = <cfoutput>#Form.editme#</cfoutput>
  </cfquery>
  EDIT <cfoutput>#form.editme#</cfoutput><br>
<cfelse>
  <cfquery name="getItem" datasource="context">
  select * from ItemAdd
  <!--- An empty copy of Item --->
  </cfquery>
  ADD<br>
  <cfif len(form.delme)>
    <cfinclude template="delete.cfm">
    <cfset form.delme="">
  <cfelseif len(form.addme)>
    <cfset myaction="insert.cfm">
  </cfif>
</cfif>