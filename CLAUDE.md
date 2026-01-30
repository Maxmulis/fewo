# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Technology Stack

- **Ruby**: 3.2.2
- **Rails**: ~8.0
- **Database**: SQLite3
- **Frontend**: Hotwire (Turbo + Stimulus), Import Maps for JavaScript modules
- **Styling**: Tailwind CSS v4 with DaisyUI v5.5.14 component library
- **Authentication**: Devise with devise_invitable
- **Email**: Brevo (formerly Sendinblue) for production email delivery

## Development Commands

### Starting the Application
```bash
bin/dev
```
This uses foreman to start the Rails server on port 3000.

### Running Tests
```bash
rails test
rails test:system
```

### Database Operations
```bash
rails db:migrate
rails db:seed
rails db:reset
```

### Linting
```bash
rubocop
```

### JavaScript Management
```bash
bin/importmap pin <package-name>
bin/importmap unpin <package-name>
```
Uses Import Maps - no build step required. JavaScript modules are loaded directly by the browser.

### CSS/Styling Management
```bash
bin/rails tailwindcss:build
bin/rails tailwindcss:watch
```
Tailwind CSS v4 with DaisyUI. Configuration in `config/tailwind.config.js`. Theme customization available through DaisyUI themes.

## Domain Model & Architecture

This is a camp/event registration management system for managing households, people, and their registrations to camps.

### Core Models & Relationships

**Person** → **Household** → **Registration** → **Camp**

- **Person**: Individual with first_name, name, dob, phone. Can optionally belong to a Household and have an associated User account.
- **Household**: Groups people together (family unit) with shared address information (street, number, zip_code, town, country_code, recipient).
- **Registration**: Links a Person to a Camp with arrival/departure dates. Has complex validation:
  - Person must belong to a Household to register
  - Underage people (< 18 at camp start) require an adult household member to be registered first
  - If the last adult registration is deleted, all household registrations for that camp are destroyed
- **Camp**: Belongs to a Place, has start_date and end_date. `Camp.next` returns the next upcoming camp.
- **User**: Authentication model (Devise) that belongs to a Person. Uses devise_invitable for invitation workflow.

### Key Business Rules

1. People cannot register for camps unless they belong to a Household
2. Underage participants need an adult from their household already registered
3. Deleting the last adult registration cascades to delete all household member registrations for that camp
4. Age calculation is done at camp start date, not current date
5. User invitations are created with `skip_invitation: true` and must be sent separately

### Routing Structure

- Root path: `people#index`
- Nested routes: People can be created under households (`/households/:id/people/new`)
- Registrations nested under camps
- Custom route: `PATCH /users/invite/:id` for sending user invitations

### Controllers

- **PeopleController**: Handles person CRUD with search functionality (LIKE queries on first_name/name). Creates associated User accounts via Devise invitable when email is provided.
- **HouseholdsController**: Standard CRUD for households
- **RegistrationsController**: Creates registrations for people to camps
- **CampsController**: Read-only views for camps
- **UsersController**: Custom invite action to trigger Devise invitations

### Views

Uses ERB templates with Turbo for SPA-like navigation. Search functionality implemented in shared partials.

**UI Component System**: Reusable DaisyUI components in `app/views/shared/components/`:
- `_button.html.erb` - Button component with variants (primary, secondary, ghost, etc.)
- `_card.html.erb` - Card container component
- `_form_input.html.erb` - Form input component (text, email, password, textarea, select, date, checkbox)
- `_badge.html.erb` - Badge/label component with variants and sizes
- `_alert.html.erb` - Alert component (success, error, warning, info) with icons and dismissible option
- `_table.html.erb` - Table component with optional zebra striping

**Design System**:
- Primary color: #3b82f6 (blue)
- Theme: DaisyUI "light" theme with custom primary color
- Responsive design tested on desktop (1440x900) and mobile (375x667)
- All views redesigned with consistent DaisyUI components including Devise authentication pages

### Email Configuration

- Development: Email delivery disabled by default (commented out Brevo config)
- Production: Uses Brevo SMTP relay with credentials stored in Rails encrypted credentials
- Credentials accessed via: `Rails.application.credentials.dig(:brevo, :username)` and `:smtp_key`

### Test Suite

Uses Rails default testing framework (Minitest) with:
- Model tests in `test/models/`
- Controller tests in `test/controllers/`
- System tests with Capybara and Selenium
