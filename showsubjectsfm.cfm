<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Search Subject Information</title>
    <cfinclude template = "../generalfp.css">
  </head>

    <cfinclude template = "../headerfp.cfm">

    <cfquery name="getSubjects"
             datasource="#Request.DSN#"
             username="#Request.username#"
             password="#Request.password#">
      select subjectid, subject_lastname, subject_firstname
            from tbsubject
            order by 2
    </cfquery>
    <h4>E-mail Search: Select a Person</h4>
    <form action="emailform.cfm" method="post">
      <table>
        <tr>
          <th>Subject: </th>
          <td>
              <select name="subjectid">
                <cfoutput query="getSubjects">
                  <option value="#subjectid#">#subject_lastname & ', ' &subject_firstname#</option>
                </cfoutput>
              </select>
          </td>
         </tr>
         <tr>
          <td>&nbsp;</td>
          <td><input name="submit" type="submit" value="View/Update E-mail"/></td>
         </tr>
       </table>
     </form>

<h4>Phone Number Search: Select a Person</h4>
    <form action="phoneform.cfm" method="post">
      <table>
        <tr>
          <th>Subject: </th>
          <td>
              <select name="subjectid">
                <cfoutput query="getSubjects">
                  <option value="#subjectid#">#subject_lastname & ', ' &subject_firstname#</option>
                </cfoutput>
              </select>
          </td>
         </tr>
         <tr>
          <td>&nbsp;</td>
          <td><input name="submit" type="submit" value="View/Update Phone"/></td>
         </tr>
       </table>
     </form>

<h4>Address Search: Select a Person</h4>
    <form action="addressform.cfm" method="post">
      <table>
        <tr>
          <th>Subject: </th>
          <td>
              <select name="subjectid">
                <cfoutput query="getSubjects">
                  <option value="#subjectid#">#subject_lastname & ', ' &subject_firstname#</option>
                </cfoutput>
              </select>
          </td>
         </tr>
         <tr>
          <td>&nbsp;</td>
          <td><input name="submit" type="submit" value="View/Update Address"/></td>
         </tr>
       </table>
     </form>

    <cfinclude template = "../footerfp.cfm">

    </body>
</html>