<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Show Subject Measurements</title>
    <cfinclude template = "../generalfp.css">
  </head>

  <body>

    <cfinclude template = "../headerfp.cfm">

    <cfparam name="URL.experimentid" default="AAAA" type="string">
      <cfparam name="URL.versionid" default="XXXXX" type="string">
      <cfparam name="URL.subjectid" default="YYYYY" type="string">

<cfif URL.experimentid NEQ "AAAA">

          <!--- ### Report Code Starts Here --->

        <cfquery name="getSubjectMeasurement"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          select experimentid, versionid, subjectid, measureno
             from tbmeasurement
             where experimentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.experimentid#"> and
             versionid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.versionid#"> and
             subjectid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.subjectid#">
        </cfquery>

        <cfquery name="getSubjectMeasureList"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          select experimentid, versionid, subjectid, measureno, datanumber, datachar, measuretype
             from tbmeasurement
             where experimentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.experimentid#"> and
             versionid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.versionid#"> and
             subjectid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.subjectid#">
             order by 1
        </cfquery>


        <cfif getSubjectMeasurement.RecordCount IS 0>
          <h4>No measurements for this subject, please</h4>
           <h4><a href="showSubjectData.cfm?experimentid=<cfoutput>#URL.experimentid#</cfoutput>&versionid=<cfoutput>#URL.versionid#</cfoutput>">try another subject</a></h4>
            <h4>or</h4>
           <h4><a href="">add a measurement for this subject</a><h4>
        <cfelse>
            <h3>
               Experiment ID: <cfoutput>#getSubjectMeasureList.experimentid#</cfoutput>
               Version ID: <cfoutput>#getSubjectMeasureList.versionid#</cfoutput>
               Subject ID: <cfoutput>#getSubjectMeasureList.subjectid#</cfoutput>
            </h3>
            <h4>
              <cfif getSubjectMeasureList.RecordCount IS 0>
                  Currently there are no measurements for this experiment.
              <cfelseif getSubjectMeasureList.RecordCount IS 1>
                  There is 1 measurement for this subject
              <cfelse>
                  There are
                  <cfoutput>#getSubjectMeasureList.RecordCount#</cfoutput>
                  notes for this subject.
              </cfif>  <!--- ### getSubjectMeasurement.RecordCount IS 0 --->
            </h4>

           <cfif getSubjectMeasureList.RecordCount GT 0>
            <table>
             <tr>
              <th>Measurement<br />Number</th>
              <th>Number Variable</th>
              <th>Char<br />Variable</th>
              <th>Measurement<br />Type</th>
              <th>Edit<br />Subject's<br />Measurement</th>
              <th>Delete<br />Subject's<br />Measurement</th>
             </tr>
             <cfoutput query="getSubjectMeasureList"> 
             <tr <cfif CurrentRow MOD  2 IS 1>style="background-color: ##D5DBDD"</cfif>>
              <td style="text-align: center">#measureno#</td>
              <td style="text-align: center">#datanumber#</td>
              <td style="text-align: center">#datachar#</td>
              <td style="text-align: center">#measuretype#</td>
              <td style="text-align: center">
                <cfform name="pick" action="measurementform.cfm" method="post">
                <input type="hidden" name="experimentid" value="#URL.experimentid#" />
                <input type="hidden" name="versionid" value="#versionid#" />
                <input type="hidden" name="subjectid" value="#subjectid#" />
                <input type="hidden" name="measureno" value="#measureno#" />
                <input type="submit" value="Update" />
                </cfform>
              </td>
              <td style="text-align: center">
                <cfform name="pick" action="measurementform.cfm" method="post">
                <input type="hidden" name="experimentid" value="#URL.experimentid#" />
                <input type="hidden" name="versionid" value="#versionid#" />
                <input type="hidden" name="subjectid" value="#subjectid#" />
                <input type="hidden" name="measureno" value="#measureno#" />
                <input type="submit" value="Delete" />
                </cfform>
              </td>
             </cfoutput>
            </table>
    </cfif>    <!--- ### getSubjectMeasureList.RecordCount GT 0 --->

          <h4><a href="showSubjectData.cfm?experimentid=<cfoutput>#URL.experimentid#</cfoutput>&versionid=<cfoutput>#URL.versionid#</cfoutput>">Other Subjects for This Experiment</a></h4>
          <h4><a href="showexperimentsandsubjectnotes.cfm?experimentid=<cfoutput>#URL.experimentid#</cfoutput>">Other Versions of This Experiment</a></h4>
           <h4><a href="showexperimentsandsubjectnotes.cfm">Choose another Experiment</a></h4>

        </cfif> <!--- ### getSubjectMeasurement.RecordCount IS 0 --->

    <cfelse>

    <!--- ### Form Code Starts Here --->

        <cfquery name="getSubjectMeasurements"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          select experimentid, versionid, subjectid, measureno
             from tbmeasurement
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
        <cfoutput query="getSubjectMeasurements">
         <tr <cfif CurrentRow MOD  2 IS 1>style="background-color: ##D5DBDD"</cfif>>
          <td style="text-align: center"><a href="shownotes.cfm?experimentid=#getSubjectMeasurements.experimentid#&versionid=#getSubjectMeasurements.versionid#&subject=#getSubjectMeasurements.subjectid#">#getSubjectMeasurements.experimentid#</a></td>
          <td>#getSubjectMeasurements.versionid#</td>
          <td>#getSubjectMeasurements.subjectid#</td>
          </tr>
        </cfoutput>
       </table>

</cfif> <!--- ### URL.experimentid NEQ "AAAA" --->

    <cfinclude template = "../footerfp.cfm">

    </body>
</html>