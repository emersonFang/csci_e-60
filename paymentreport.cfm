<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<cfinclude template = "../headerfp.cfm">

  <head>
    <title>Show Payment Data</title>
    <cfinclude template = "../generalfp.css">
  </head>


        <cfquery name="getPaymentsView"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
         select * from payments_view
        </cfquery>

        <cfquery name="getTotalPaid"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
         SELECT SUM(payment) as Total_Paid
         from payments_view
        </cfquery>

        <cfquery name="getTotalPaidPerSubject"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
         select * from totalpaidpersubject
        
        </cfquery>
        
        <cfquery name="getSubjectPaidOver500"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
        select subjectid, subject_firstname, subject_lastname, total_paid
		from totalpaidpersubject
		where total_paid>500
		order by 1
        </cfquery>

<h3><U>The Lab has paid</U></h3>
<h5>$<cfoutput query="getTotalPaid">#Total_Paid#</cfoutput></h5>


<h3><U>Payments ordered by Experiment:</U></h3>

<cfif getPaymentsView.RecordCount IS 0>
          <h5>No subjects have been paid yet.</h5>
        	<cfelse>
            <h4>
              <cfif getPaymentsView.RecordCount IS 1>
                  There is 1 payment record.
              <cfelse>
                  There are
                  <cfoutput>#getPaymentsView.RecordCount#</cfoutput>
                  payments total.
              </cfif>
            </h5>

           <cfif getPaymentsView.RecordCount GT 0>
            <table>
             <tr>
              <th>SubjectID</th>
              <th>First Name</th>
              <th>Last Name</th>
              <th>Payment</th>
              <th>Experiment Type</th>
              <th>Version Number</th>
              <th>Experiment Name</th>
              <th>Date Paid</th>
             </tr>
             <cfoutput query="getPaymentsView"> 
             <tr <cfif CurrentRow MOD  2 IS 1>style="background-color: ##D5DBDD"</cfif>>
              <td style="text-align: center">#subjectid#</td>
              <td style="text-align: center">#subject_firstname#</td>
              <td style="text-align: center">#subject_lastname#</td>
              <td style="text-align: center">#payment#</td>
              <td style="text-align: center">#exptype#</td>
              <td style="text-align: center">#versionid#</td>
              <td style="text-align: center">#versiondescription#</td>
              <td style="text-align: center">#exp_particip_date#</td>
             </cfoutput>
            </table>
    	</cfif>    <!--- ### getSubjectNoteList.RecordCount GT 0 --->
</cfif>

<h3><U>Total Paid Per Subject:</U></h3>
<cfif getTotalPaidPerSubject.RecordCount IS 0>
          <h5>No subjects have been paid yet.</h4>
        <cfelse>
            <h5>
              <cfif getTotalPaidPerSubject.RecordCount IS 1>
                  There is 1 payment record.
              <cfelse>
                  There are
                  <cfoutput>#getTotalPaidPerSubject.RecordCount#</cfoutput>
                  payment records.
              </cfif>
            </h5>

           <cfif getTotalPaidPerSubject.RecordCount GT 0>
            <table>
             <tr>
              <th>SubjectID</th>
              <th>First Name</th>
              <th>Last Name</th>
              <th>Total Paid</th>
             </tr>
             <cfoutput query="gettotalpaidpersubject"> 
             <tr <cfif CurrentRow MOD  2 IS 1>style="background-color: ##D5DBDD"</cfif>>
              <td style="text-align: center">#subjectid#</td>
              <td style="text-align: center">#subject_firstname#</td>
              <td style="text-align: center">#subject_lastname#</td>
              <td style="text-align: center">#total_paid#</td>
             </cfoutput>
            </table>
    	</cfif>    <!--- ### getSubjectNoteList.RecordCount GT 0 --->
</cfif>

<h3><U>Subjects Paid over $500:</U></h3>
<cfif getSubjectPaidOver500.RecordCount IS 0>
          <h5>No subjects have been paid over $500.</h5>
        <cfelse>
            <h5>
              <cfif getSubjectPaidOver500.RecordCount IS 1>
                  There is 1 subject paid over $500.
              <cfelse>
                  There are
                  <cfoutput>#getSubjectPaidOver500.RecordCount#</cfoutput>
                  subjects paid over $500.
              </cfif>
            </h5>

           <cfif getSubjectPaidOver500.RecordCount GT 0>
            <table>
             <tr>
              <th>SubjectID</th>
              <th>First Name</th>
              <th>Last Name</th>
              <th>Total Paid</th>
             </tr>
             <cfoutput query="getSubjectPaidOver500"> 
             <tr <cfif CurrentRow MOD  2 IS 1>style="background-color: ##D5DBDD"</cfif>>
              <td style="text-align: center">#subjectid#</td>
              <td style="text-align: center">#subject_firstname#</td>
              <td style="text-align: center">#subject_lastname#</td>
              <td style="text-align: center">#total_paid#</td>
             </cfoutput>
            </table>
    	</cfif>    <!--- ### getSubjectNoteList.RecordCount GT 0 --->
</cfif>

<cfinclude template = "../footerfp.cfm">