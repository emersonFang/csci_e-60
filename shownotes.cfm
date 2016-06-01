<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Show Subject Notes</title>
    <cfinclude template = "../generalfp.css">
  </head>

  <body>

    <cfparam name="URL.experimentid" default="AAAA" type="string">
      <cfparam name="URL.versionid" default="XXXXX" type="string">
      <cfparam name="URL.subjectid" default="YYYYY" type="string">

<cfif URL.experimentid NEQ "AAAA">

          <!--- ### Report Code Starts Here --->

        <cfquery name="getSubjectNote"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          select experimentid, versionid, subjectid, noteno
             from tbparticipant_note
             where experimentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.experimentid#"> and
             versionid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.versionid#"> and
             subjectid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.subjectid#">
        </cfquery>

        <cfquery name="getSubjectNoteList"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          select experimentid, versionid, subjectid, noteno, note, notetype, notedate, notetime, researcherID
             from tbparticipant_note
             where experimentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.experimentid#"> and
             versionid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.versionid#"> and
             subjectid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.subjectid#">
             order by 1
        </cfquery>


        <cfif getSubjectNote.RecordCount IS 0>
          <h4>No notes for this subject, please</h4>
           <h4><a href="showSubjectData.cfm?experimentid=<cfoutput>#URL.experimentid#</cfoutput>&versionid=<cfoutput>#URL.versionid#</cfoutput>">try another subject</a></h4>
            <h4>or</h4>
           <h4><a href="">add a note for this subject</a><h4>
        <cfelse>
            <h3>
               Experiment ID: <cfoutput>#getSubjectNoteList.experimentid#</cfoutput>
               Version ID: <cfoutput>#getSubjectNoteList.versionid#</cfoutput>
               Subject ID: <cfoutput>#getSubjectNoteList.subjectid#</cfoutput>
            </h3>
            <h4>
              <cfif getSubjectNoteList.RecordCount IS 0>
                  Currently there are no notes for this experiment.
              <cfelseif getSubjectNoteList.RecordCount IS 1>
                  There is 1 note for this subject
              <cfelse>
                  There are
                  <cfoutput>#getSubjectNoteList.RecordCount#</cfoutput>
                  notes for this subject.
              </cfif>  <!--- ### getSubjectNote.RecordCount IS 0 --->
            </h4>

           <cfif getSubjectNoteList.RecordCount GT 0>
            <table>
             <tr>
              <th>Note<br />Number</th>
              <th>Note</th>
              <th>Note<br />Type</th>
              <th>Date of Note</th>
              <th>Time Written</th>
              <th>Researcher ID</th>
              <th>Update<br />Subject's<br />Note</th>
              <th>Delete<br />Subject's<br />Note</th>
             </tr>
             <cfoutput query="getSubjectNoteList"> 
             <tr <cfif CurrentRow MOD  2 IS 1>style="background-color: ##D5DBDD"</cfif>>
              <td style="text-align: center">#noteno#</td>
              <td style="text-align: center">#note#</td>
              <td style="text-align: center">#notetype#</td>
              <td style="text-align: center">#notedate#</td>
              <td style="text-align: center">#notetime#</td>
              <td style="text-align: center">#researcherid#</td>
              <td style="text-align: center">
                <cfform action="noteform.cfm" method="post">
                <input type="hidden" name="experimentid" value="#URL.experimentid#" />
                <input type="hidden" name="versionid" value="#versionid#" />
                <input type="hidden" name="subjectid" value="#subjectid#" />
                <input type="hidden" name="noteno" value="#noteno#" />
                <input type="hidden" name="notedate" value="#notedate#" />
                <input type="hidden" name="notetime" value="#notetime#" />
                <input type="submit" name="editme" value="Update" />
                </cfform>
              </td>
              <td style="text-align: center">
                <cfform name="pick" action="noteform.cfm" method="post">
                <input type="hidden" name="experimentid" value="#URL.experimentid#" />
                <input type="hidden" name="versionid" value="#versionid#" />
                <input type="hidden" name="subjectid" value="#subjectid#" />
                <input type="hidden" name="noteno" value="#noteno#" />
                <input type="hidden" name="notedate" value="#notedate#" />
                <input type="hidden" name="notetime" value="#notetime#" />
                <input type="submit" name="delme" value="Delete" />
                </cfform>
              </td>
             </cfoutput>
            </table>
    </cfif>    <!--- ### getSubjectNoteList.RecordCount GT 0 --->

          <h4><a href="showSubjectData.cfm?experimentid=<cfoutput>#URL.experimentid#</cfoutput>&versionid=<cfoutput>#getSubjectNote.versionid#</cfoutput>">Other Subjects for This Experiment</a></h4>
          <h4><a href="showexperimentsandsubjectnotes.cfm?experimentid=<cfoutput>#URL.experimentid#</cfoutput>">Other Versions of This Experiment</a></h4>
           <h4><a href="showexperimentsandsubjectnotes.cfm">Choose another Experiment</a></h4>

        </cfif> <!--- ### getSubjectNote.RecordCount IS 0 --->

    <cfelse>

    <!--- ### Form Code Starts Here --->

        <cfquery name="getSubjectNotes"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          select experimentid, versionid, subjectid, noteno
             from tbparticipant_note
             where experimentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.experimentid#"> and
             versionid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.versionid#"> and
             subjectid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.subjectid#">
        </cfquery>

    <h4>Select a Subject</h4>
      <table>
         <tr>
          <th>Experiment<br />ID</th>
          <th>Version ID</th>
          <th>Subject ID</th>
         </tr>
        <cfoutput query="getSubjectNotes">
         <tr <cfif CurrentRow MOD  2 IS 1>style="background-color: ##D5DBDD"</cfif>>
          <td style="text-align: center"><a href="shownotes.cfm?experimentid=#getSubjectNotes.experimentid#&versionid=#getSubjectNotes.versionid#&subject=#getSubjectNotes.subjectid#">#getSubjectNotes.experimentid#</a></td>
          <td>#getSubjectNotes.versionid#</td>
          <td>#getSubjectNotes.subjectid#</td>
          </tr>
        </cfoutput>
       </table>

</cfif> <!--- ### URL.experimentid NEQ "AAAA" --->

    </body>
</html>