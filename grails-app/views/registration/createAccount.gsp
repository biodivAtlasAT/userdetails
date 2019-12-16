<!doctype html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <meta name="section" content="home"/>
    <g:if test="${!alreadyRegistered && edit}">
        <g:set var="title">${message(code:"createAccount.title.editAccount", default:"Edit your account")}</g:set>
        <meta name="breadcrumbParent" content="${g.createLink(controller: 'profile')},My Profile" />
    </g:if>
    <g:else>
        <g:set var="title">${message(code:"createAccount.title.createAccount", default:"Create your account")}</g:set>
    </g:else>
    <title>${title}</title>
    <asset:stylesheet src="application.css" />
    <asset:stylesheet src="createAccount.css" />
    <g:if test="${grailsApplication.config.recaptcha.siteKey}">
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    </g:if>
</head>
<body>

<div class="row" style="padding-left:20px; padding-right:10px">
    <h1>${title}</h1>
    <g:if test="${flash.message}">
        <div class="alert alert-warning">
            ${flash.message}
        </div>
    </g:if>
    <g:if test="${inactiveUser}">
        <div class="row">
            <div class="col-sm-12">
                <div class="well">
                    <p class="text-danger">${message(code:"createAccount.inactiveUser.part1", default:"A user is already registered with the email address ")}<strong>${params.email}</strong> ${message(code:"createAccount.inactiveUser.part2", default:" however it is currently disabled.")}
                    </p>

                    <p>
                        ${message(code:"createAccount.inactiveUser.supportEmailMessage", default:"If you think this is an error or you disabled your account please contact ")}
                         <a href="mailto:${grailsApplication.config.supportEmail}">${grailsApplication.config.supportEmail}</a>.
                    </p>
                </div>
            </div>
        </div>
    </g:if>
    <g:elseif test="${alreadyRegistered}">
        <div class="row">
            <div class="col-sm-12">
                <div class="well">
                    <p class="text-danger">${message(code:"createAccount.userAlreadyExists", default:"A user is already registered with the email address ")}<strong>${params.email}</strong>.</p>

                    <p>
                        ${message(code:"createAccount.userAlreadyExists.info1", default:"To login with this user name, ")}<a
                            href="${grailsApplication.config.security.cas.loginUrl}">click here</a>.<br/>
                        ${message(code:"createAccount.userAlreadyExists.info2", default:"To start the process of resetting your password, ")}<g:link controller="registration"
                                                                                 action="forgottenPassword"
                                                                                 params="${[email: params.email]}">${message(code:"createAccount.userAlreadyExists.info3", default:"click here")}</g:link>.
                    </p>
                </div>
            </div>
        </div>
    </g:elseif>

    <div class="row">
        <div class="col-md-8 col-md-push-4">
            <div class="well">
                <g:if test="${!edit}">
                    <h2>${message(code:"createAccount.info1", default:"Do I need to create an account?")}</h2>

                    <p>${message(code:"createAccount.info2", default:"We recommend to register in order to use all the features of the application.")}

                </g:if>
                <h2>${message(code:"createAccount.info.yourAccount.header", default:"Your account")}</h2>
                <p>
                    ${message(code:"createAccount.info.yourAccount.info", default:"Your email address will be your ALA account login.")}
                </p>
                <g:if test="${!edit}">
                    <p>${message(code:"createAccount.info.activationLink", default:"An &quot;account activation&quot; link will be emailed to the address provided. You need click this link, in order to complete the registration process. Note, you may need to check you spam/junk mail folder, as activation emails sometimes get caught by mail filters.")}
                </g:if>
                <h2>${message(code:"createAccount.privacyPolicy.header", default:"Privacy policy")}</h2>
                <p>
                    ${message(code:"createAccount.privacyPolicy.info", default:"For the Atlas' policy on the collection and use of personal information see our ")}
                    <a href="${grailsApplication.config.privacyPolicy}">${message(code:"createAccount.privacyPolicy.link", default:"Privacy Policy")}</a>.
                </p>
                <h2>${message(code:"createAccount.termsOfUse.header", default:"Terms of use")}</h2>
                <p>
                    ${message(code:"createAccount.termsOfUse.header.info", default:"For the Atlas' terms of use see our ")}<a href="${grailsApplication.config.termsOfUse}"> ${message(code:"createAccount.termsOfUse.header.link", default:"Terms of Use")}</a>
                </p>
            </div>
        </div>
        <div class="col-md-4 col-md-pull-8">
            <div>
            <g:form name="updateAccountForm" method="POST" action="${edit ? 'update' : 'register'}" controller="registration" useToken="true" onsubmit="updateAccountSubmit.disabled = true; return true;">
                <div class="form-group">
                    <label for="firstName">${message(code:"createAccount.firstName", default:"First name")}</label>
                    <input id="firstName" name="firstName" type="text" class="form-control" value="${user?.firstName}" data-validation-engine="validate[required]"/>
                </div>
                <div class="form-group">
                    <label for="lastName">${message(code:"createAccount.lastName", default:"Last name")}</label>
                    <input id="lastName" name="lastName" type="text" class="form-control" value="${user?.lastName}"  data-validation-engine="validate[required]"/>
                </div>
                <div class="form-group">
                    <label for="email">${message(code:"createAccount.emailAddress", default:"Email address")}</label>
                    <input id="email" name="email" type="text" class="form-control" value="${user?.email}"
                           data-validation-engine="validate[required,custom[email]]"
                           data-errormessage-value-missing="${message(code:'createAccount.emailAddressRequired', default:'Email is required!')}"
                    />
                </div>

                <g:if test="${!edit}">
                    <div class="form-group">
                    <label for="password">${message(code:'createAccount.password', default:'Password')}</label>
                    <input id="password"
                           name="password"
                           class="form-control"
                           value=""
                           data-validation-engine="validate[required, minSize[8]]"
                           data-errormessage-value-missing="${message(code:'createAccount.passwordIsRequired', default:'Password is required!')}"
                           type="password"
                    />
                    </div>
                    <div class="form-group">
                    <label for="reenteredPassword">${message(code:'createAccount.passwordReentered', default:'Reentered password')}</label>
                    <input id="reenteredPassword"
                           name="reenteredPassword"
                           class="form-control"
                           value=""
                           data-validation-engine="validate[required, minSize[8]]"
                           data-errormessage-value-missing="${message(code:'createAccount.passwordIsRequired', default:'Password is required!')}"
                           type="password"
                    />
                    </div>
                </g:if>
                <div class="form-group">
                    <label for="organisation">${message(code:'createAccount.oraginsation', default:'Organisation')}</label>
                    <input id="organisation" name="organisation" type="text" class="form-control" value="${props?.organisation}"/>
                </div>
                <div class="form-group">
                    <label for="country">${message(code:'createAccount.country', default:'Country')}</label>
                    <g:select id="country" name="country"
                              class="form-control chosen-select"
                              value="${props?.country ?: 'AT'}"
                              keys="${l.countries()*.isoCode}"
                              from="${l.countries()*.name}"
                              noSelection="['':message(code:'createAccount.choseYourCountry', default:'- Choose your country -')]"
                              valueMessagePrefix="ala.country."
                    />
                </div>
                <div class="form-group">
                    <label for="state">${message(code:'createAccount.stateProvince', default:'State / province')}</label>
                    <g:select id="state" name="state"
                              class="form-control chosen-select"
                              value="${props?.state}"
                              keys="${l.states(country: props?.country ?: 'AT')*.isoCode}"
                              from="${l.states(country: props?.country ?: 'AT')*.name}"
                              noSelection="['':message(code:'createAccount.choseYourStateProvince', default:'- Choose your state -')]"
                              valueMessagePrefix="ala.state."
                    />
                </div>
                <div class="form-group">
                    <label for="city">${message(code:'createAccount.city', default:'City')}</label>
                    <input id="city" name="city" type="text" class="form-control" value="${props?.city}" />
                </div>
                <g:if test="${edit}">
                    <button id="updateAccountSubmit" class="btn btn-primary">${message(code:'createAccount.updateAccount', default:'Update account')}</button>
                    <button id="disableAccountSubmit" class="btn btn-danger">${message(code:'createAccount.disableAccount', default:'Disable account')}</button>
                </g:if>
                <g:else>
                    <g:if test="${grailsApplication.config.recaptcha.siteKey}">
                        <div class="g-recaptcha" data-sitekey="${grailsApplication.config.recaptcha.siteKey}"></div>
                        <br/>
                    </g:if>
                    <button id="updateAccountSubmit" class="btn btn-primary">${message(code:'createAccount.createAccount', default:'Create account')}</button>
                </g:else>
            </g:form>
            </div>
            <g:if test="${flash.invalidToken}">
                ${message(code:"createAccount.buttonTwice", default:"Please don't click the button twice.")}
            </g:if>
        </div>
   </div>
</div>
</body>
<asset:javascript src="createAccount.js" asset-defer="" />
<asset:script type="text/javascript">
    $(function() {
        userdetails.initCountrySelect('.chosen-select', '#country', '#state', "${g.createLink(uri: '/ws/registration/states')}");

        $('#updateAccountForm').validationEngine('attach', { scroll: false });
        $("#updateAccountSubmit").click(function(e) {

            $("#updateAccountSubmit").attr('disabled','disabled');

            var pm = $('#password').val() == $('#reenteredPassword').val();
            if(!pm){
                alert("${message(code:"createAccount.passwordsDoNotMatch", default:"The supplied passwords do not match!")}");
            }

            var valid = $('#updateAccountForm').validationEngine('validate');

            if (valid && pm) {
                $("form[name='updateAccountForm']").submit();
            } else {
                $('#updateAccountSubmit').removeAttr('disabled');
                e.preventDefault();
            }
        });

        $("#disableAccountSubmit").click(function(e) {

            $("#disableAccountSubmit").attr('disabled','disabled');

            var valid = confirm("${message(code: 'default.button.delete.user.confirm.message', default: "Are you sure want to disable your account? You won't be able to login again. You will have to contact support@ala.org.au in the future if you want to reactivate your account.")}");

            if (valid) {
                $('#updateAccountForm').validationEngine('detach');
                $("form[name='updateAccountForm']").attr('action','disableAccount');
                $("form[name='updateAccountForm']").submit();
            } else {
                $('#disableAccountSubmit').removeAttr('disabled');
                e.preventDefault();
            }
        });



    });
</asset:script>
</html>
