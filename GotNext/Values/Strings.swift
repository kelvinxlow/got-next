//
//  Strings.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-07-31.
//

import Foundation

public class Strings {
    static let appName = "Got Next"
    static let slogan = "Do you have what it takes to be on next?"
    
    static let activeEvents = "Active Events"
    static let upcomingEvents = "Upcoming Events"
    static let pastEvents = "Past Events"
    
    static let accept = "Accept"
    static let decline = "Decline"
    static let confirm = "Confirm"
    static let cancel = "Cancel"
    
    // LoginView 
    static let signIn = "Sign In"
    static let username = "Username"
    static let email = "Email"
    static let emailAddress = "Email Address"
    static let password = "Password"
    static let signInButton = "Let's Roll"
    static let newAccount = "Create new account"
    static let forgotPassword = "Forgot password?"
    
    
    // LoginView Status Messages
    static let createAccountError = "There was an error creating your account"
    static let loginError = "There was an error logging you in"
    static let passwordResetError = "There was an error sending the reset email"
    static let passwordResetSent = "Check your email to reset your password"
    
    // CreateEventView
    static let createEvent = "Create Event"
    static let name = "Name"
    static let date = "Date"
    static let dateTime = "Date @ Time"
    static let location = "Location"
    static let address = "Address"
    static let description = "Description"
    static let eventDetails = "Event Details"
    static let people = "People Needed"
    
    // CreateEventView Status Messages
    static let errorMessage = "There was an error saving your event, please make sure all fields are filled"
    static let successMessage = "Your event was successfully saved!"
    
    // GroupEventDetailsView
    static let details = "Details"
    static let peopleNeeded = "People Needed"
    static let peopleAttending = "People Attending"
    static let eventEnded = "This event has ended"
    static let takeDown = "Take down event?"
    static let delete = "Delete"
    static let deleteEvent = "Delete event (This cannot be undone)"
    static let alreadyAttending = "You are already signed up for this event"
    static let withdraw = "Withdraw"
    static let signUp = "Sign up now!"
    static let attendingEvent = "I'm coming to this event"
    
    // GroupEventDetailsView Status Messages
    static let errorDeleting = "There was an error processing your delete request. Please try again"
    static let errorUpdating = "There was an error updating your attendance status. Please try again"
    
    // UsernameView
    static let userViewMessage = "Welcome to Got Next, please pick a user name to continue"
    static let continueText = "Continue"
    static let setName = "Set name"
    static let usernameErrorMessage = "There was an error setting your username please try again"
    static let noUsername = "Please enter a username"
    static let usernameSuccessMessage = "Username set! Click continue to proceed to Got Next"
    
    // ProfileView
    static let noUsernameFound = "No Username Found"
    static let updateUsername = "Update Username"
    static let newUsername = "New username"
    static let updateName = "Update Name"
    static let emailError = "Fatal error no email found"
    static let changePassword = "Change Password"
    static let oldPassword = "Old password"
    static let newPassword = "New password"
    static let setPassword = "Set Password"
    
    // ProfileView Status Messages
    static let usernameUpdated = "Username updated!"
    static let usernameUpdateErrorMessage = "There was an error updating your username please try again"
    static let oldPasswordIncorrect = "Old password incorrect"
    static let unexpectedError = "An unexpected error has occured, please try again later"
    static let passwordUpdateErrorMessage = "There was an error updating your password"
    static let passwordUpdated = "Your password was successfully updated"
    
}
