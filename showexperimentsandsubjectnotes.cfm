<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Show Experiments and Subject Data</title>
    <cfinclude template = "../generalfp.css">
  </head>

  <body>

    <cfinclude template = "../headerfp.cfm">

    <cfparam name="URL.experimentid" default="AAAA" type="string">
        <cfparam name="URL.versionid" default="XXXXXX" type="string">

    <cfif URL.experimentid NEQ "AAAA">

    <!--- ### Report Code Starts Here --->

        <cfquery name="getExperiment"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          select experimentid
             from tbexperiment
             where experimentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.experimentid#">
        </cfquery>

        <cfquery name="getExperimentVersion"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          select b.experimentid, b.exptype, a.versionid, a.versiondescription 
             from tbexp_version a, tbexperiment b
             where a.experimentid = b.experimentid AND
             b.experimentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.experimentid#">
             order by 1,2
        </cfquery>

        <cfif getExperiment.RecordCount IS 0>
           Invalid Experiment, please
           <a href="showexperimentsandsubjectnotes.cfm">try again</a>
        <cfelse>
            <h3>
               Experiment: <cfoutput>#getExperimentVersion.experimentid#</cfoutput>
            </h3>
            <h4>
              <cfif getExperimentVersion.RecordCount IS 0>
                  Currently there are no versions of this experiment
              <cfelseif getExperimentVersion.RecordCount IS 1>
                  There is 1 version of this experiment
              <cfelse>
                  There are
                  <cfoutput>#getExperimentVersion.RecordCount#</cfoutput>
                  versions of this experiment
              </cfif>  <!--- ### getExperimentVersion.RecordCount IS 0 --->
            </h4>
			 		
           <cfif getExperimentVersion.RecordCount GT 0>
            <table>
             <tr>
              <th>Experiment ID</th>
              <th>Version Number</th>
              <th>Version<br />Description</th>
              <th>View<br /> Subjects</th>
            </tr>
             
             <cfoutput query="getExperimentVersion">             
             <tr <cfif CurrentRow MOD  2 IS 1>style="background-color: ##D5DBDD"</cfif>>
              <td style="text-align: center">#experimentid#</td>
              <td>#versionid#</td>
              <td style="text-align: center">#versiondescription#</td>
              <td style="text-align: center"><a href="showSubjectData.cfm?experimentid=#getExperimentVersion.experimentid#&versionid=#getExperimentVersion.versionid#">View Subjects</a></td>
              </tr>
             </cfoutput>
            </table>
           </cfif>    <!--- ### getExperimentVersion.RecordCount GT 0 --->

           <h4><a href="showexperimentsandsubjectnotes.cfm">Choose another Experiment</a></h4>

        </cfif> <!--- ### getExperiment.RecordCount IS 0 --->

    <cfelse>

    <!--- ### Form Code Starts Here --->

    <cfquery name="getExperiments"
             datasource="#Request.DSN#"
             username="#Request.username#"
             password="#Request.password#">
      select a.experimentid, a.exptype, b.exptype_description
         from tbexperiment a, tbexperiment_type b
         where a.exptype = b.exptype
         order by 1
    </cfquery>
    <h4>Select an Experiment</h4>
      <table>
         <tr>
          <th>Experiment<br />ID</th>
          <th>Experiment Type</th>
          <th>Description</th>
         </tr>
        <cfoutput query="getExperiments">
         <tr <cfif CurrentRow MOD  2 IS 1>style="background-color: ##D5DBDD"</cfif>>
        <td style="text-align: center"><a href="showexperimentsandsubjectnotes.cfm?experimentid=#getExperiments.experimentid#">#getExperiments.experimentid#</a></td>
          <td>#getExperiments.exptype#</td>
          <td style="text-align: center">#getExperiments.exptype_description#</td>
          </tr>
        </cfoutput>
       </table>

</cfif> <!--- ### URL.exptype NEQ "AAAA" --->

    <cfinclude template = "../footerfp.cfm">

    </body>
</html>