<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Show Subject Address</title>
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

        <cfquery name="getSubjectAddress"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
             select b.subject_lastname, b.subject_firstname, a.addressno, a.streetnumber, a.streetname, a.city, a.state, a.zip, a.addresstype
             from tbsubject_address a, tbsubject b
             where a.subjectid = b.subjectid and
             a.subjectid = 
              <cfqueryparam cfsqltype="CF_SQL_VARCHAR"
              value="#Form.subjectid#">
             order by 3
        </cfquery>

        <cfif getSubjectAddress.RecordCount IS 0>
           No physical addresses for the subject, please
           <a href="showsubjectsfm.cfm">try again</a>
        <cfelse>
            <h3>
               Subject: <cfoutput>#getSubject.subject_firstname & ' ' &  getSubject.subject_lastname#</cfoutput>
               Subject ID: <cfoutput>#getSubject.subjectid#</cfoutput>
            </h3>
            <h4>
              <cfif getSubjectAddress.RecordCount IS 0>
                  Currently there are no physical addresses on file for this subject.
              <cfelseif getSubjectAddress.RecordCount IS 1>
                  There is 1 physical address for this subject
              <cfelse>
                  There are
                  <cfoutput>#getSubjectAddress.RecordCount#</cfoutput>
                  physical addresses for this subject
              </cfif>  <!--- ### getSubjectAddress.RecordCount IS 0 --->
            </h4>
            <h4>
              <cfif getSubjectAddress.RecordCount LT 1>
                  <cfset NL=Chr(13) />
                  <cfset warning = "#NL#!!WARNING: NO PHYSICAL ADDRESS ON FILE FOR THE SUBJECT!!"/>
                  <cfoutput>
                  #warning#
                </cfoutput>  
              </cfif><!--- ### getSubjectAddress.RecordCount LT 1 --->
            </h4>
           <cfif getSubjectAddress.RecordCount GT 0>
            <table>
             <tr>
              <th>Address Type</th>
              <th>Address No.</th>
              <th>Street Number</th>
              <th>Street</th>
              <th>City</th>
              <th>State</th>
              <th>Zip</th>
              <th>Edit<br />Subject's<br />Address</th>
              <th>Delete<br />Subject's<br />Address</th>
             </tr>
             <cfoutput query="getSubjectAddress">
             <tr <cfif CurrentRow MOD  2 IS 1>style="background-color: ##D5DBDD"</cfif>>
              <td>#addresstype#</td>
              <td>#addressno#</td>
              <td>#streetnumber#</td>
              <td>#streetname#</td>
              <td>#city#</td>
              <td>#state#</td>
              <td>#zip#</td>
              <td style="text-align: center">
                <cfform name="pick" action="addressform.cfm" method="post">
                <input type="hidden" name="subjectid" value="#Form.subjectid#" />
                <input type="hidden" name="addressno" value="#addressno#" />
                <input type="submit" name="editme" value="Update" />
                </cfform>
              </td>
              <td style="text-align: center">
                <cfform name="pick" action="addressform.cfm" method="post">
                <input type="hidden" name="subjectid" value="#Form.subjectid#" />
                <input type="hidden" name="addressno" value="#addressno#" />
                <input type="submit" name="delme" value="Delete" />
                </cfform>
              </td>
             </tr>
             </cfoutput>
            </table>
           </cfif>    <!--- ### getSubjectEmail.RecordCount GT 0 --->

           <h4><a href="showsubjectsfm.cfm">Choose another Subject</a></h4>

        </cfif> <!--- ### getSubjectEmail.RecordCount IS 0 --->

    <cfelse>

        <h4>Invalid Subject, please
		      <a href="showsubjectsfm.cfm">try again</a></h4>

    </cfif> <!--- ### Form.subjectid NEQ "AAA" --->

    </body>
</html>