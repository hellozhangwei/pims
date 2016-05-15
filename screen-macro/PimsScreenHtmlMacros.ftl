
<#--<#include "classpath://template/DefaultScreenMacros.html.ftl"/>-->
<#include "../../../template/screen-macro/DefaultScreenMacros.html.ftl"/>

<#macro "subscreens-panel">
    <#assign dynamic = .node["@dynamic"]! == "true" && .node["@id"]?has_content>
    <#assign dynamicActive = 0>
    <#assign displayMenu = sri.activeInCurrentMenu!>
    <#assign menuId><#if .node["@id"]?has_content>${.node["@id"]}-menu<#else>subscreensPanelMenu</#if></#assign>
    <#assign menuTitle = .node["@title"]!sri.getActiveScreenDef().getDefaultMenuName()!"Menu">
    <#if .node["@type"]! == "popup">
    <li id="${menuId}" class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">${ec.resource.expand(menuTitle, "")} <i class="glyphicon glyphicon-chevron-right"></i></a>
        <ul class="dropdown-menu">
            <#list sri.getActiveScreenDef().getMenuSubscreensItems() as subscreensItem>
                <#assign urlInstance = sri.buildUrl(subscreensItem.name)>
                <#if urlInstance.isPermitted()>
                    <li class="<#if urlInstance.inCurrentScreenPath>active</#if>"><a href="<#if urlInstance.disableLink>#<#else>${urlInstance.minimalPathUrlWithParams}</#if>">
                        <#if urlInstance.sui.menuImage?has_content>
                            <#if urlInstance.sui.menuImageType == "icon">
                                <i class="${urlInstance.sui.menuImage}" style="padding-right: 8px;"></i>
                            <#elseif urlInstance.sui.menuImageType == "url-plain">
                                <img src="${urlInstance.sui.menuImage}" width="18" style="padding-right: 4px;"/>
                            <#else>
                                <img src="${sri.buildUrl(urlInstance.sui.menuImage).url}" height="18" style="padding-right: 4px;"/>
                            </#if>
                        <#else>
                            <i class="glyphicon glyphicon-link" style="padding-right: 8px;"></i>
                        </#if>
                    ${ec.resource.expand(subscreensItem.menuTitle, "")}
                    </a></li>
                </#if>
            </#list>
        </ul>
    </li>
    <#-- NOTE: not putting this script at the end of the document so that it doesn't appear unstyled for as long -->
    <#-- move the menu to the header menus section -->
    <script>$("#${.node["@header-menus-id"]!"header-menus"}").append($("#${menuId}"));</script>

    ${sri.renderSubscreen()}
    <#elseif .node["@type"]! == "stack">
    <h1>LATER stack type subscreens-panel not yet supported.</h1>
    <#elseif .node["@type"]! == "wizard">
    <h1>LATER wizard type subscreens-panel not yet supported.</h1>
    <#else>
    <#-- default to type=tab -->
    <div<#if .node["@id"]?has_content> id="${.node["@id"]}-menu"</#if>>
        <#if displayMenu!>
            <ul<#if .node["@id"]?has_content> id="${.node["@id"]}-menu"</#if> class="nav nav-pills nav-stacked col-lg-1" role="tablist">
                <#list sri.getActiveScreenDef().getMenuSubscreensItems() as subscreensItem>
                    <#assign urlInstance = sri.buildUrl(subscreensItem.name)>
                    <#if urlInstance.isPermitted()>
                        <#if dynamic>
                            <#assign urlInstance = urlInstance.addParameter("lastStandalone", "true")>
                            <#if urlInstance.inCurrentScreenPath>
                                <#assign dynamicActive = subscreensItem_index>
                                <#assign urlInstance = urlInstance.addParameters(ec.web.requestParameters)>
                            </#if>
                        </#if>
                        <li class="<#if urlInstance.disableLink>disabled<#elseif urlInstance.inCurrentScreenPath>active</#if>"><a href="<#if urlInstance.disableLink>#<#else>${urlInstance.minimalPathUrlWithParams}</#if>">${ec.resource.expand(subscreensItem.menuTitle, "")}</a></li>
                    </#if>
                </#list>
            </ul>
        </#if>
    <#-- add to navbar bread crumbs too -->
        <div id="${menuId}-crumb" class="navbar-text">${ec.resource.expand(menuTitle, "")} <i class="glyphicon glyphicon-chevron-right"></i></div>
        <script>$("#navbar-menu-crumbs").append($("#${menuId}-crumb"));</script>

        <#if !dynamic || !displayMenu>
        <#-- these make it more similar to the HTML produced when dynamic, but not needed: <div<#if .node["@id"]?has_content> id="${.node["@id"]}-active"</#if> class="ui-tabs-panel"> -->
        ${sri.renderSubscreen()}
        <#-- </div> -->
        </#if>
    </div>
        <#if dynamic && displayMenu!>
            <#assign afterScreenScript>
            $("#${.node["@id"]}").tabs({ collapsible: true, selected: ${dynamicActive},
            spinner: '<span class="ui-loading">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>',
            ajaxOptions: { error: function(xhr, status, index, anchor) { $(anchor.hash).html("Error loading screen..."); } },
            load: function(event, ui) { <#-- activateAllButtons(); --> }
            });
            </#assign>
            <#t>${sri.appendToScriptWriter(afterScreenScript)}
        </#if>
    </#if>
</#macro>