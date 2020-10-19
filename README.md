# Win Daily

See it as a live, malfunctioning app at http://www.windaily.app

## What this is

An app to help you competitively develop habits with friends.

The idea was born from attempting to stay physically fit while on a conference at sea for a week. A few Dutch friends and I agreed to do 100 burpees every day at 11:00 am. For me, knowing they would be there to do the work pushed me to always show up and do the work.

We kept it up for months afterwards by sending each other WhatsApp messages. I've come to the conclusion that the WhatsApp thread isn't the best way to do this sort of thing. Win Daily is my attempt at making competitive, collabrative habit formation with friends more addictive.

## User Story

- [x] User creates a challenge
- [x] Daily or Weekly
- [x] For user to share with friends they must sign in with a phone + PW or email + PW.
- [x] Challenge created so we can invite friends
- [x] Challenge updates daily with element if participants are involved
- [x] Allow for users to invite friends via email
- [x] Get the twilio API working
- [ ] Allow for users to invite friends via phone (get twilio functioning for users)
- [ ] Get confirmable working with devise to tighten up security
- [ ] Clean up mailers and figure out how to get them using templates
- [ ] Resize avatar images before saving them to the DB so we can have clean avatars
- [ ] Get jQuery loading before - Notifications are broken.
- [ ] Set up the WhatsApp integration (https://github.com/getninjas/whatsapp)
- [ ] Follow this tutorial to set up subscription payments via stripe (https://www.toptal.com/ruby-on-rails/ruby-on-rails-ecommerce-tutorial)
- [ ] Make sure the challenge titles are unique....
- [ ] Challenge create fill add helper needs to reflect the file name when a user is creatinga  new challenge


Public/Private ability for both challenges and users needs to be set up
- [ ] The views need to be hooked up
- [ ] Can the users set the challenge to be public or private?
- [ ] The controllers need to ensure they aren't showing public challenges and users
- [ ] The testing needs to reach these features
- [ ] Test to ensure private don't show
- [ ] Tests to show public do show
- [ ] We want people in challenges to be able to see users there... this will be a tricky controller call to get users that might be set to visibiliity _only me_ to still be visiible to those they are in challenges with....


## Completed

### Technologies

- Bootstrap 4 (includes jQuery and Popper)
- User authentication with Devise
- Persistent image storage with ActiveStorage + AWS (s3)

### Data Model

**User** - Email or phone numbers
**Challenge** - A challenge is created by a user. Multiple users can join a challenge.
**Win** - A win a single entry associated with a challenge.

## Tech

- [Devise](https://github.com/heartcombo/devise) for user authentication
- [Bootstrap 4](https://getbootstrap.com/docs/4.0) for mobile friendliness
