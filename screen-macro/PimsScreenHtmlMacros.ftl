
<#--<#include "classpath://template/DefaultScreenMacros.html.ftl"/>-->
<#include "../../../template/screen-macro/DefaultScreenMacros.html.ftl"/>

<#macro "subscreens-menu">
    <#assign displayMenu = sri.activeInCurrentMenu!>
    <#assign menuId = .node["@id"]!"subscreensMenu">
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
    <#-- move the menu to the header-menus container -->
    <script>$("#${.node["@header-menus-id"]!"header-menus"}").append($("#${menuId}"));</script>
    <#elseif .node["@type"]! == "popup-tree">
    <#else>
    <#-- default to type=tab -->
        <#if displayMenu!>
        <ul<#if .node["@id"]?has_content> id="${.node["@id"]}"</#if> class="nav nav-pills nav-stacked" role="tablist">
            <#list sri.getActiveScreenDef().getMenuSubscreensItems() as subscreensItem>
                <#assign urlInstance = sri.buildUrl(subscreensItem.name)>
                <#if urlInstance.isPermitted()>
                    <li class="<#if urlInstance.inCurrentScreenPath>active</#if><#if urlInstance.disableLink> disabled</#if>"><#if urlInstance.disableLink>${ec.resource.expand(subscreensItem.menuTitle, "")}<#else><a href="${urlInstance.minimalPathUrlWithParams}">${ec.l10n.localize(subscreensItem.menuTitle)}</a></#if></li>
                </#if>
            </#list>
        </ul>
        </#if>
    <#-- add to navbar bread crumbs too -->
    <div id="${menuId}-crumb" class="navbar-text">${ec.resource.expand(menuTitle, "")} <i class="glyphicon glyphicon-chevron-right"></i></div>
    <script>$("#navbar-menu-crumbs").append($("#${menuId}-crumb"));</script>
    </#if>
</#macro>