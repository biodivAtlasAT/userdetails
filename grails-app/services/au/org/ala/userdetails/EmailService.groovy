package au.org.ala.userdetails

import au.org.ala.auth.PasswordResetFailedException
import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder;

class EmailService {

    def grailsApplication
    MessageSource messageSource

    static transactional = false

    def sendPasswordReset(user, authKey, emailSubject=null, emailTitle = null, emailBody=null, password=null) throws PasswordResetFailedException {

        if (!emailSubject) {
            emailSubject = messageSource.getMessage("email.service.sendPasswordReset.subject",null, "Reset your password", LocaleContextHolder.getLocale())
            //emailSubject = "Reset your password"
        }
        if (!emailTitle) {
            emailTitle = messageSource.getMessage("email.service.sendPasswordReset.title",null, "Reset your password", LocaleContextHolder.getLocale())
            //emailTitle = "Reset your password"
        }

        if (!emailBody) {
            emailBody = messageSource.getMessage("email.service.sendPasswordReset.body",null, "Please click the link below to reset your password.  This will take you to a form where you can provide a new password for your account.", LocaleContextHolder.getLocale())
            //emailBody = "Please click the link below to reset your password.  This will take you to a form where you can provide a new password for your account."
        }
        try {
            sendMail {
              from grailsApplication.config.emailSenderTitle+"<" + grailsApplication.config.emailSender + ">"
              subject emailSubject
              to user.email
              body (view: '/email/resetPassword',
                    plugin:"email-confirmation",
                    model:[link:getServerUrl() + "resetPassword/" +  user.id +  "/"  + authKey, emailTitle: emailTitle, emailBody: emailBody, password: password ]
              )
            }
        } catch (Exception ex) {
            throw new PasswordResetFailedException(ex)
        }
    }

    def sendAccountActivation(user, authKey){
        sendMail {
          from grailsApplication.config.emailSenderTitle+"<" + grailsApplication.config.emailSender + ">"
          subject messageSource.getMessage("email.service.sendAccountActivation.subject",null, "Activation", LocaleContextHolder.getLocale())
          to user.email
          body (view: '/email/activateAccount',
                plugin:"email-confirmation",
                model:[link:getServerUrl() + "activateAccount/" + user.id + "/"  + authKey, orgNameLong: grailsApplication.config.skin.orgNameLong ]
          )
        }
    }

    def sendAccountActivationSuccess(def user, def activatedAlerts) {
        sendMail {
            from grailsApplication.config.emailSenderTitle+"<" + grailsApplication.config.emailSender + ">"
            subject messageSource.getMessage("email.service.sendAccountActivationSuccess.subject",null, "Account activated successfully", LocaleContextHolder.getLocale())
            to user.email
            body (view: '/email/activateAccountSuccess',
                    plugin:"email-confirmation",
                    model:[activatedAlerts: activatedAlerts, alertsUrl: grailsApplication.config.alerts.url]
            )
        }
    }

    def sendGeneratedPassword(user, generatedPassword){
        sendMail {
          from grailsApplication.config.emailSenderTitle+"<" + grailsApplication.config.emailSender + ">"
          subject messageSource.getMessage("email.service.sendGeneratedPassword.subject",null, "Accessing your account", LocaleContextHolder.getLocale())
          to user.email
          body (view: '/email/accessAccount',
                plugin:"email-confirmation",
                model:[link:getLoginUrl(user.email), generatedPassword: generatedPassword]
          )
        }
    }

    def getLoginUrl(email){
            grailsApplication.config.security.cas.loginUrl  +
                    "?email=" + email +
                    "&service=" + URLEncoder.encode(getMyProfileUrl(),"UTF-8")
    }

    def getMyProfileUrl(){
            grailsApplication.config.grails.serverURL  +
                    "/myprofile/"

    }

    def getServerUrl(){
        grailsApplication.config.grails.serverURL +
                    "/registration/"
    }
}
