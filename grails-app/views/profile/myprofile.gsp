<%@ page import="grails.util.Holders" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <meta name="section" content="home"/>
    <meta name="breadcrumb" content="My Profile" />
    <title>${message(code:"myprofile.title", default:"My profile")} | ${grailsApplication.config.skin.orgNameLong}</title>
    <asset:stylesheet src="application.css" />
</head>
<body>

<div class="row">
    <div class="col-md-6">
        <h1>${message(code:"myprofile.header.hello", default:"Hello")} ${user.firstName} !</h1>
        <ul class="userdetails-menu">
            <li>
                <g:link controller="registration" action="editAccount">
                    ${message(code:"myprofile.items.updateProfile", default:"Update your profile")}
                </g:link>
            </li>
            <li>
                <a href="${grailsApplication.config.lists.url}">
                    ${message(code:"myprofile.items.updloadesLists", default:"View your uploaded species lists")}
                </a>
            </li>
            <li>
                <g:link controller="registration" action="forgottenPassword">
                    ${message(code:"myprofile.items.resetPassword", default:"Reset my password")}
                </g:link>
            </li>

            <g:if test="${isAdmin}">
            <li>
                <g:link controller="admin">
                    ${message(code:"myprofile.items.adminTools", default:"Admin tools")}
                </g:link>
            </li>
            </g:if>
        </ul>

        <g:if test="${Holders.config.getProperty('oauth.providers.flickr.enabled', Boolean, true)}">
        <h3>External site linkages</h3>
        <div class="well well-small">
            <h4>Flickr</h4>
            <g:if test="${props.flickrUsername}">
                <strong>You have connected to flickr account with username:
                    <a href="http://www.flickr.com/photos/${props.flickrId}">${props.flickrUsername}</a>.
                </strong>
                <p>
                Linking with Flickr enables images shared through

                <a href="http://www.flickr.com/groups/encyclopedia_of_life/">Flickr EOL Group</a>

                to be linked to your Atlas account so they can be attributed to you.
                </p>



                <g:link controller="profile" class="btn btn-default" action="removeLink" params="[provider: 'flickr']">Remove link to flickr account</g:link>
            </g:if>
            <g:else>
                <p>
                Linking with Flick enables images shared through Flickr to be linked to your Atlas account
                so they can be attributed to you.
                </p>

                <span class="btn btn-default">
                    <oauth:connect provider="flickr">Link to my Flickr account</oauth:connect>
                </span>
            </g:else>
        </div>
        </g:if>
        <g:if test="${Holders.config.getProperty('oauth.providers.inaturalist.enabled', Boolean, false)}">
        <div class="well well-small">
            <h4>${grailsApplication.config.inaturalist.name}</h4>
            <g:if test="${props.inaturalistId}">
                <strong>You have connected to ${grailsApplication.config.inaturalist.name} with the username:
                    <u:link baseProperty="inaturalist.baseUrl" paths="['people', props.inaturalistId]">${props.inaturalistUsername}</u:link>
                </strong>
                <p>
                    <u:link baseProperty="biocache.search.baseUrl" params='[q: grailsApplication.config.inaturalist.searchQuery, fq: "alau_user_id:${props.inaturalistUsername}"]'>View my iNaturalist observations in ${grailsApplication.config.skin.orgNameShort}</u:link><br>
                    <u:link baseProperty="biocache.search.baseUrl" params='[q: grailsApplication.config.inaturalist.searchQuery + " OR " + grailsApplication.config.inaturalist.sightingsSearchQuery, fq: "alau_user_id:${props.inaturalistUsername} OR alau_user_id:\"${user.id}\""]'>View my iNaturalist observations and my ${grailsApplication.config.skin.orgNameShort} Sightings in ${grailsApplication.config.skin.orgNameShort}</u:link>
                </p>

                <g:link controller="profile" class="btn btn-default" action="removeLink" params="[provider: 'inaturalist']">Remove link to iNaturalist account</g:link>
            </g:if>
            <g:else>
                <p>
                    Linking your ALA account with iNaturalist will make it easier to find your observations in ALA.
                </p>

                <span class="btn btn-default">
                    <oauth:connect provider="inaturalist">Link to my iNaturalist account</oauth:connect>
                </span>
            </g:else>
        </div>
        </g:if>
    </div>
</div>
</body>
</html>
