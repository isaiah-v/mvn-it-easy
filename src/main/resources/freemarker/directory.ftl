<#ftl output_format="HTML">

<#macro parent path><#compress>
  /<#if path.parent??>${path.parent}</#if>
</#compress></#macro>

<#macro filepath path file><@compress>
    <#if path??><#if path.toString()?has_content && !path?starts_with("/")>/</#if>${path}</#if><#if file??><#if file?has_content && !file?starts_with("/")>/</#if>${file}</#if>
</@compress></#macro>

<html>
    <body>
        ${path}<br/>
        <#if !isRoot>D - <a href="<@parent path=path/>"> .. </a> </#if><br/>
        <#list directories as directory>
            D - <a href="<@filepath path=path file=directory />">${directory}</a><br/>
        </#list>
        <#list files as file>
            F - <a href="<@filepath path=path file=file />">${file}</a><br/>
        </#list>
    </body>
</html>