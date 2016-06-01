<cflogin>
<cfif not (isDefined("FORM.userLogin") and
isDefined("FORM.userPassword"))>
<cfinclude template="login.cfm">
<cfabort>
<cfelse>
<cfquery name="getUser"
datasource="#APPLICATION.dataSource#"
username="#APPLICATION.username#"
password="#APPLICATION.password#">
select *
from tblogin
where uname = <cfqueryparam
cfsqltype="CF_SQL_VARCHAR"
value="#Form.UserLogin#"> and
pwd = <cfqueryparam cfsqltype="CF_SQL_VARCHAR“
value="#Form.UserPassword#">
</cfquery>