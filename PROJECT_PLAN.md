Revised plan with the new product assumptions: this should move from “two text fields + midpoint coordinates” to “dynamic participants +
  place search + map-first recommendation.”

  1. Revised Architecture
  Keep the feature-first structure, but make the meetup feature more domain-shaped.

  lib/
    core/
      config/
      theme/
      errors/
      utils/
    shared/
      widgets/
    features/
      meetup/
        domain/
          models/
            participant.dart
            place.dart
            meetup_candidate.dart
            meetup_plan.dart
            travel_profile.dart
          repositories/
            place_repository.dart
            meetup_repository.dart
          services/
            meetup_selection_service.dart
        data/
          providers/
            geocoding_provider.dart
            mock_geocoding_provider.dart
            maps_provider.dart
          repositories/
            place_repository_impl.dart
            meetup_repository_impl.dart
        logic/
          meetup_controller.dart
          meetup_state.dart
        presentation/
          screens/
          widgets/

  Recommended models:

  class Participant {
    final String id;
    final String name;
    final Place? origin;
  }

  class Place {
    final String id;
    final String displayName;
    final String formattedAddress;
    final double latitude;
    final double longitude;
    final PlaceSource source;
  }

  class MeetupCandidate {
    final Place place;
    final double score;
    final String reason;
    final List<ParticipantTravelEstimate> estimates;
  }

  class MeetupPlan {
    final List<Participant> participants;
    final MeetupCandidate? selectedCandidate;
    final List<MeetupCandidate> alternatives;
  }

  class PlacePrediction {
    final String id;
    final String mainText;
    final String secondaryText;
    final PlaceSource source;
  }

  Coordinates can exist internally in domain/data models, but presentation should never render raw latitude/longitude. The UI should
  render map markers, place names, addresses, estimated travel burden, and reasoning.

  2. Screen Flow
  Primary flow:

  1. Home / meetup setup screen
      - Dynamic friend list.
      - Each participant has name and place autocomplete.
      - Add/remove participant controls.
      - Minimum viable count should be 2, but architecture supports N.
  2. Place autocomplete interaction
      - User types a location.
      - Controller requests predictions from PlaceRepository.
      - UI shows suggestions.
      - Selecting a suggestion resolves it to a full Place.
  3. Calculate meetup
      - Enabled when required participants have resolved places.
      - Controller requests candidate generation and scoring.
      - Loading state is shown on the map/result area.
  4. Map result screen or result panel
      - Map is primary UI.
      - Show participant origin markers.
      - Show selected meetup marker prominently.
      - Show alternative candidates as secondary markers/list.
      - Result card shows place name, address, fairness summary, and reason, not coordinates.
  5. Candidate details
      - Optional details panel for travel estimates per participant.
      - Future: open in external maps, route preview, venue category filters.

  3. Data Flow
  Recommended flow:

  User input
    -> MeetupController
    -> MeetupState

  Autocomplete query
    -> PlaceRepository.searchPlaces(query)
    -> GeocodingProvider.autocomplete(query)
    -> List<PlacePrediction>
    -> MeetupState.autocompleteResults

  Prediction selected
    -> PlaceRepository.resolvePlace(predictionId)
    -> GeocodingProvider.resolvePlace(...)
    -> Place
    -> Participant.origin updated

  Calculate meetup
    -> MeetupRepository.findMeetupPlan(participants, preferences)
    -> MeetupSelectionService.generateAndScoreCandidates(...)
    -> MeetupPlan
    -> MeetupState.result

  Map UI
    <- MeetupState.participants
    <- MeetupState.selectedCandidate
    <- MeetupState.alternatives

  State shape should explicitly model the product flow:

  class MeetupState {
    final List<ParticipantInputState> participants;
    final bool isSearchingPlaces;
    final bool isCalculating;
    final MeetupPlan? plan;
    final String? errorMessage;
  }

  Avoid one global isLoading once autocomplete and calculation can happen independently.

  4. Implementation Phases
  Phase 1: Domain foundation
  Add domain models for participants, places, predictions, candidates, and meetup plans. Keep current mock behavior behind provider
  interfaces.

  Phase 2: Dynamic participant flow
  Replace two fixed text controllers with a list-based participant form. Add add/remove participant behavior and validation. Still use
  mock provider internally if needed.

  Phase 3: Repository boundaries
  Introduce PlaceRepository, GeocodingProvider, MeetupRepository, and MeetupSelectionService. Move current hardcoded lookup behind
  MockGeocodingProvider so the app no longer depends directly on a hardcoded database.

  Phase 4: Autocomplete and fuzzy matching
  Add debounced autocomplete state. For now, fuzzy matching can live in the mock provider. Later, real providers can replace it without
  changing UI/controller code.

  Phase 5: Map-first result UI
  Integrate a map package. For Flutter, likely candidates are google_maps_flutter, flutter_map, or mapbox_maps_flutter. I’d choose based
  on target platform, licensing, and provider strategy. The map widget should consume normalized Place/candidate data, not provider-
  specific objects.

  Phase 6: Real geocoding provider
  Add an implementation for the selected provider. Keep API keys/config outside source. Add error handling, empty results, rate limits,
  and ambiguous place handling.

  Phase 7: Better selection algorithm
  Move beyond raw geographic midpoint. Add scoring based on travel distance/time, fairness, and nearby valid meetup places.

  Meetup Selection Algorithm
  Short-term algorithm:

  1. Require at least two resolved participant origins.
  2. Compute geographic center as an internal seed.
  3. Generate candidate places near the center using provider search, for example cafes, malls, parks, transit stations.
  4. Score each candidate:
      - lower average travel distance/time is better
      - lower maximum participant burden is better
      - lower variance between participants is better
      - place quality/category availability can influence score later

  Example scoring idea:

  score =
    averageTravelCost * 0.45 +
    maxTravelCost * 0.35 +
    fairnessVariance * 0.20

  The chosen result should be a real place near the balanced area, not just a coordinate midpoint.

  Long-term algorithm should use travel time from a routing/distance matrix provider. Distance by latitude/longitude is a weak proxy,
  especially in cities.

  Repository And Service Boundaries
  GeocodingProvider
  Provider-specific API integration.

  Responsibilities:

  - autocomplete text queries
  - resolve prediction to place
  - nearby place search
  - normalize provider response into app models

  PlaceRepository
  App-facing abstraction over place search.

  Responsibilities:

  - debouncing/caching policy if desired
  - fuzzy fallback behavior
  - provider switching
  - consistent errors

  MeetupSelectionService
  Pure domain service where possible.

  Responsibilities:

  - generate center/seed
  - ask for nearby candidates through repository/service boundary
  - score candidates
  - return ranked candidates

  MeetupRepository
  Use-case-level orchestration.

  Responsibilities:

  - accept participants and preferences
  - coordinate candidate generation
  - return MeetupPlan

  MeetupController
  Presentation state owner.

  Responsibilities:

  - manage participant input state
  - call repositories
  - expose loading/error/result states
  - avoid map/provider-specific logic

  5. Commit Plan
  Commit 1: Introduce domain models
  Add Participant, Place, PlacePrediction, MeetupCandidate, MeetupPlan, and related enums/value objects.

  Commit 2: Add repository/provider interfaces
  Add PlaceRepository, GeocodingProvider, MeetupRepository, and initial mock implementations wrapping current mock behavior.

  Commit 3: Add meetup state/controller
  Move validation and calculation state out of HomeScreen.

  Commit 4: Convert UI to dynamic participants
  Replace fixed two-field form with add/remove participant rows and participant-specific autocomplete state.

  Commit 5: Add autocomplete behavior
  Wire debounced query, predictions, selection, and unresolved/free-text validation.

  Commit 6: Add map result UI
  Introduce map package and render origin/result markers. Hide coordinates from user-facing UI.

  Commit 7: Replace midpoint-only result with candidate scoring
  Generate ranked meetup candidates and show selected + alternatives.

  Commit 8: Add tests
  Unit tests for fuzzy matching, participant validation, state transitions, and selection scoring. Widget tests for dynamic participant
  flow.

  6. Risks
  Map provider choice has long-term cost. Google Maps, Mapbox, and OpenStreetMap-based options have different pricing, licensing, platform
  support, and API limits.

  Autocomplete quality depends heavily on the provider. Local fuzzy matching is useful for mocks, but real-world place search should come
  from a real geocoding API.

  Travel-time fairness requires routing or distance matrix data. Without that, the app can only approximate convenience.

  Dynamic participant input increases state complexity. Each participant may have its own query, predictions, selected place, validation
  error, and loading state.

  Provider-specific data can leak into the app if boundaries are not enforced. Normalize responses into app-owned Place and
  PlacePrediction models immediately.

  A map-first UI needs careful fallback states: no results, partial participant locations, provider failure, offline mode, and unsupported
  platforms.