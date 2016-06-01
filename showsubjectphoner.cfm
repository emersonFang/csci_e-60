<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Show Subject Phone Number</title>
    <cfinclude template = "../generalfp.css">
  </head>

  <body>

    <cfparam name="Form.subjectid" default="AAA" type="string">

    <cfif Form.subjectid NEQ "AAA">

    <!--- ### Report Code Starts Here --->

        <cfquery name="getSubject"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          select subjectid, subject_lastname, subject_firstname
             from tbsubject
             where subjectid =
             <cfqueryparam cfsqltype="CF_SQL_VARCHAR"
              value="#Form.subjectid#">
        </cfquery>

        <cfquery name="getSubjectPhone"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
             select a.lineno, a.phoneno, a.phonetype
             from tbsubject_phone a, tbsubject b
             where a.subjectid = b.subjectid and
             a.subjectid = 
              <cfqueryparam cfsqltype="CF_SQL_VARCHAR"
              value="#Form.subjectid#">
             order by 1
        </cfquery>

        <cfif getSubjectPhone.RecordCount IS 0>
           No e-mail addresses for the subject, please
           <a href="showsubjectsfm.cfm">try again</a>
        <cfelse>
            <h3>
               Subject: <cfoutput>#getSubject.subject_firstname & ' ' &  getSubject.subject_lastname#</cfoutput>
               Subject ID: <cfoutput>#getSubject.subjectid#</cfoutput>
            </h3>
            <h4>
              <cfif getSubjectPhone.RecordCount IS 0>
                  Currently there are no phone numbers on file for this subject.
              <cfelseif getSubjectPhone.RecordCount IS 1>
                  There is 1 phone number for this subject
              <cfelse>
                  There are
                  <cfoutput>#getSubjectPhone.RecordCount#</cfoutput>
                  phone numbers for this subject
              </cfif>  <!--- ### getSubjectEmail.RecordCount IS 0 --->
            </h4>
            <h4>
              <cfif getSubjectPhone.RecordCount LT 1>
                  <cfset NL=Chr(13) />
                  <cfset warning = "#NL#!!WARNING: NO PHONE NUMBERS ON FILE FOR THE SUBJECT!!"/>
                  <cfoutput>
                  #warning#
                </cfoutput>  
              </cfif><!--- ### getSubjectEmail.RecordCount LT 1 --->
            </h4>
           <cfif getSubjectPhone.RecordCount GT 0>
            <table>
             <tr>
              <th>Line No.</th>
              <th>Phone Type</th>
              <th>Phone Number</th>
              <th>Edit<br />Subject's<br />Phone Number</th>
              <th>Delete<br />Subject's<br />Phone Number</th>
             </tr>
             <cfoutput query="getSubjectPhone">
             <tr <cfif CurrentRow MOD  2 IS 1>style="background-color: ##D5DBDD"</cfif>>
              <td>#lineno#</td>
              <td>#phonetype#</td>
              <td>#phoneno#</td>
              <td style="text-align: center">
                <cfform name="pick" action="phoneform.cfm" method="post">
                <input type="hidden" name="subjectid" value="#Form.subjectid#" />
                <input type="hidden" name="lineno" value="#lineno#" />
                <input type="submit" name="editme" value=<cfoutput>"Update Line Number #lineno#"</cfoutput> />
                </cfform>
              </td>
              <td style="text-align: center">
                <cfform name="pick" action="phoneform.cfm" method="post">
                <input type="hidden" name="subjectid" value="#Form.subjectid#" />
                <input type="hidden" name="lineno" value="#lineno#" />
                <input type="submit" name="delme" value="Delete" />
                </cfform>
              </td>

             </tr>
             </cfoutput>
            </table>
           </cfif>    <!--- ### getSubjectPhone.RecordCount GT 0 --->

           <h4><a href="showsubjectsfm.cfm">Choose another Subject</a></h4>

        </cfif> <!--- ### getSubjectPhone.RecordCount IS 0 --->

    <cfelse>

        <h4>Invalid Subject, please
		      <a href="showsubjectsfm.cfm">try again</a></h4>

    </cfif> <!--- ### Form.subjectid NEQ "AAA" --->

    </body>
</html>