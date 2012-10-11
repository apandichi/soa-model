<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet version="2.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">  <xsl:template match="/">    <html>      <head>        <title>SchemaDiffGenerator</title>        <link rel="stylesheet" type="text/css" href="static/a.css" />        <link href="static/jquery.treeview.css" rel="stylesheet" />        <script type="text/javascript" src="static/jquery.js" />        <script type="text/javascript" src="static/jquery.treeview.js" />        <script type="text/javascript">          $(document).ready(function(){            $("#diffs").treeview();          });        </script>      </head>      <body>        <h1>Diff Report</h1>        <h2>Compared the following documents:</h2>        <div>          <table class="s1" border="1">            <thead>              <tr>                <th>Documnet</th>                <th>TargetNamespace</th>                <th>URL</th>              </tr>            </thead>            <tbody>              <tr>                <td>SchemaA</td>                <td>                  <xsl:value-of select="/SchemaDiff/Schema-a/TargetNamespace" />                </td>                <td>                  <a href="../{/SchemaDiff/Schema-a/URL}">                    <xsl:value-of select="/SchemaDiff/Schema-a/URL" />                  </a>                </td>              </tr>              <tr>                <td>SchemaB</td>                <td>                  <xsl:value-of select="/SchemaDiff/Schema-b/TargetNamespace" />                </td>                <td>                  <a href="../{/SchemaDiff/Schema-b/URL}">                    <xsl:value-of select="/SchemaDiff/Schema-b/URL" />                  </a>                </td>              </tr>            </tbody>          </table>          <xsl:apply-templates select="/SchemaDiff/Diffs" />        </div>      </body>    </html>  </xsl:template>  <xsl:template match="Diffs">    <div>      <h2>Differences in schema B compared with A:</h2>      <xsl:if test="//@breaks = 'true'">        <div class="notice">          <img src="static/images/lightning.png"></img>          <span>The changes in this definitions invalidate the            interface.</span>        </div>      </xsl:if>      <div>        <ul id="diffs" class="treeview">          <xsl:apply-templates select="Diff" />        </ul>      </div>    </div>    <div>      <ul>        <li>          <img src="static/images/add.png"/>          Indicates that this Element has been added to the definition.        </li>        <li>          <img src="static/images/remove.png"/>          Indicates that this Element has been removed from the definition.        </li>        <li>          <img src="static/images/tick.png"/>          Indicates that the change will not influence the interface.        </li>        <li>          <img src="static/images/lightning.png"/>          Indicates that the change will invalidate the interface.        </li>      </ul>    </div>  </xsl:template>  <xsl:template match="Diff">    <ul>      <li>        <xsl:variable name="class">          <xsl:choose>            <xsl:when test="contains(Description, 'added')">add</xsl:when>            <xsl:when test="contains(Description, 'removed')">remove</xsl:when>            <xsl:when test="@safe = 'true'">safe</xsl:when>            <xsl:when test="@breaks = 'true'">breaks</xsl:when>            <xsl:otherwise></xsl:otherwise>          </xsl:choose>        </xsl:variable>        <span class="{$class}"><xsl:value-of select="Description" /></span>        <xsl:apply-templates select="Diff" />      </li>    </ul>  </xsl:template></xsl:stylesheet>