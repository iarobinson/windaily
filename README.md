# Win Daily

## What this is

An app to help you competitively develop habits with friends.

The idea was born from attempting to stay physically fit while on a conference at sea for a week. A few Dutch friends and I agreed to do 100 burpees every day at 11:00 am. For me, knowing they would be there to do the work pushed me to always show up and do the work.

We kept it up for months afterwards by sending each other WhatsApp messages. I've come to the conclusion that the WhatsApp thread isn't the best way to do this sort of thing. Win Daily is my attempt at making competitive, collabrative habit formation with friends more addictive.

## User Story

- User creates a challenge
  - Daily or Weekly
  - Description of challenge
- For user to share with friends they must sign in with a phone + PW or email + PW.
- Challenge created so we can invite friends
- Challenge updates daily with element if participants are involved

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
