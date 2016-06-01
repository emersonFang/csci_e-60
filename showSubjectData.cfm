<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Show Subject Data</title>
    <cfinclude template = "../generalfp.css">
  </head>

  <body>

    <cfinclude template = "../headerfp.cfm">

    <cfparam name="URL.experimentid" default="AAAA" type="string">
      <cfparam name="URL.versionid" default="XXXXX" type="string">


    <cfif URL.experimentid NEQ "AAAA">

          <!--- ### Report Code Starts Here --->

        <cfquery name="getExpVersion"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          select experimentid, versionid, subjectid
             from tbexp_vers_participation
             where experimentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.experimentid#"> and
             versionid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.versionid#">
        </cfquery>

        <cfquery name="getsubjectinfo"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          select experimentid, versionid, exp_particip_date, subjectid, matlab_initials, 
            gender, age, handedness, hand_used, polarityType, start_time, end_time, payment, researcherID
             from tbexp_vers_participation
             where experimentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.experimentid#"> and
             versionid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.versionid#">
             order by 1,2
        </cfquery>


        <cfif getExpVersion.RecordCount IS 0>
           No subjects for this experiment, please
           <a href="showexperimentsandsubjectnotes.cfm">try another experiment</a>
           or
           <a href="">add a subject to the experiment</a>
        <cfelse>
            <h3>
               Experiment ID: <cfoutput>#getExpVersion.experimentid#</cfoutput>
               Version: <cfoutput>#getExpVersion.versionid#</cfoutput>
            </h3>
            <h4>
              <cfif getExpVersion.RecordCount IS 0>
                  Currently there are no subjects for this experiment.
              <cfelseif getExpVersion.RecordCount IS 1>
                  There is 1 subject for this experiment
              <cfelse>
                  There are
                  <cfoutput>#getExpVersion.RecordCount#</cfoutput>
                  subjects for this experiment.
              </cfif>  <!--- ### getExpVersion.RecordCount IS 0 --->
            </h4>
          
           <cfif getExpVersion.RecordCount GT 0>
            <table>
             <tr>
              <th>Experiment<br />Date</th>
              <th>Subject<br />ID</th>
              <th>Matlab<br />Initials</th>
              <th>Gender</th>
              <th>Age</th>
              <th>Handedness</th>
              <th>Hand<br />Used</th>
              <th>Experiment<br />Polarity</th>
              <th>Experiment<br />Start<br />Time</th>
              <th>Experiment<br />End<br />Time</th>
              <th>Payment</th>
              <th>Researcher<br />ID</th>
              <th>View/Update<br />Subject's<br />Notes</th>
              <th>View/Update<br />Subject's<br />Measurements</th>
             </tr>
             <cfoutput query="getsubjectinfo"> 
             <tr <cfif CurrentRow MOD  2 IS 1>style="background-color: ##D5DBDD"</cfif>>
              <td style="text-align: center">#exp_particip_date#</td>
              <td style="text-align: center">#subjectid#</td>
              <td style="text-align: center">#matlab_initials#</td>
              <td style="text-align: center">#gender#</td>
              <td style="text-align: center">#age#</td>
              <td style="text-align: center">#handedness#</td>
              <td style="text-align: center">#hand_used#</td>
              <td style="text-align: center">#polarityType#</td>
              <td style="text-align: center">#start_time#</td>
              <td style="text-align: center">#end_time#</td>
              <td style="text-align: center">#payment#</td>
              <td style="text-align: center">#researcherID#</td>
              <td style="text-align: center"><a href="noteform.cfm?experimentid=#getsubjectinfo.experimentid#&versionid=#getsubjectinfo.versionid#&subjectid=#getsubjectinfo.subjectid#">View/Update Notes</a></td>
              <td style="text-align: center"><a href="showmeasurements.cfm?experimentid=#getsubjectinfo.experimentid#&versionid=#getsubjectinfo.versionid#&subjectid=#getsubjectinfo.subjectid#">View/Update Notes</a></td>
             </cfoutput>
            </table>
           </cfif>    <!--- ### getsubjectinfo.RecordCount GT 0 --->

        <cfquery name="getExperiment"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          select experimentid
             from tbexperiment
             where experimentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.experimentid#">
        </cfquery>
          
          <cfoutput query="getExperiment">
          <h4><a href="showexperimentsandsubjectnotes.cfm?experimentid=#getExperiment.experimentid#">Other Versions of This Experiment</a></h4>
          </cfoutput>
           <h4><a href="showexperimentsandsubjectnotes.cfm">Choose another Experiment</a></h4>

        </cfif> <!--- ### getExpVersion.RecordCount IS 0 --->

    <cfelse>

    <!--- ### Form Code Starts Here --->

    <cfquery name="getExpSubjects"
             datasource="#Request.DSN#"
             username="#Request.username#"
             password="#Request.password#">
      select experimentid, versionid, subjectid
             from tbexp_vers_participation
         order by 1, 2
    </cfquery>
    <h4>Select an Experiment Subject</h4>
      <table>
         <tr>
          <th>Experiment<br />ID</th>
          <th>Version ID</th>
          <th>Subject ID</th>
         </tr>
        <cfoutput query="getExpSubjects">
         <tr <cfif CurrentRow MOD  2 IS 1>style="background-color: ##D5DBDD"</cfif>>
          <td style="text-align: center"><a href="showSubjectData.cfm?experimentid=#getExpSubjects.experimentid#&versionid=#getExpSubjects.versionid#">#getExpSubjects.experimentid#</a></td>
          <td>#getExpSubjects.versionid#</td>
          <td>#getExpSubjects.subjectid#</td>
          </tr>
        </cfoutput>
       </table>

    </cfif> <!--- ### URL.experimentid NEQ "AAAA" --->

    <cfinclude template = "../footerfp.cfm">

    </body>
</html>