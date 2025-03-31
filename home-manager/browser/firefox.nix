{
  inputs,
  pkgs,
  lib,
  ...
}: {
  programs.browserpass.enable = true;
  programs.firefox = {
    enable = true;
    profiles.topi = {
      # Default bookmarks, do note that this might silently override any handmade bookmarks
      bookmarks = [{
        toolbar = true;
        bookmarks = import ./bookmarks.nix;
      }];

      # Extensions configured with the firefox-extensions flake
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        ublock-origin
        browserpass
        web-search-navigator
        vimium
      ];

      settings = {
        "browser.startup.homepage" = "about:home";

        # Disable irritating first-run stuff
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.feeds.showFirstRunUI" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.rights.3.shown" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.uitour.enabled" = false;
        "startup.homepage_override_url" = "";
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.addedImportButton" = true;

        # Don't ask for download dir
        "browser.download.useDownloadDir" = false;

        # Disable crappy home activity stream page
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
        "browser.newtabpage.blocked" = lib.genAttrs [
          # Youtube
          "26UbzFJ7qT9/4DhodHKA1Q=="
          # Facebook
          "4gPpjkxgZzXPVtuEoAL9Ig=="
          # Wikipedia
          "eV8/WsSLxHadrTL1gAxhug=="
          # Reddit
          "gLv0ja2RYVgxKdp0I5qwvA=="
          # Amazon
          "K00ILysCaEq8+bEqV/3nuw=="
          # Twitter
          "T9nJot5PurhJSy8n038xGA=="
        ] (_: 1);

        # Disable some telemetry cause we like privacy
        "app.shield.optoutstudies.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;

        # Things needed for the userChrome and userContent below to work
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;
        "svg.context-properties.content.enabled" = true;

        # Disable mouse wheel pasting
        "middlemouse.paste" = false;

        # Disable fx accounts
        "identity.fxaccounts.enabled" = false;
        # Disable "save password" prompt
        "signon.rememberSignons" = false;
        # Harden
        "privacy.trackingprotection.enabled" = true;
        "dom.security.https_only_mode" = true;
        # Layout
        "browser.uiCustomization.state" = builtins.toJSON {
          currentVersion = 20;
          newElementCount = 5;
          dirtyAreaCache = ["nav-bar" "PersonalToolbar" "toolbar-menubar" "TabsToolbar" "widget-overflow-fixed-list"];
          placements = {
            PersonalToolbar = ["personal-bookmarks"];
            TabsToolbar = ["tabbrowser-tabs" "new-tab-button" "alltabs-button"];
            nav-bar = ["back-button" "forward-button" "stop-reload-button" "urlbar-container" "downloads-button" "ublock0_raymondhill_net-browser-action" "_testpilot-containers-browser-action" "reset-pbm-toolbar-button" "unified-extensions-button"];
            toolbar-menubar = ["menubar-items"];
            unified-extensions-area = [];
            widget-overflow-fixed-list = [];
          };
          seen = ["save-to-pocket-button" "developer-button" "ublock0_raymondhill_net-browser-action" "_testpilot-containers-browser-action"];
        };
      };

      # userChrome.css and userContent.css from https://github.com/migueravila/simplefox
      # TODO: use nix-colors instead of hardcoded colors
      userChrome = ''
        /* Just comment the lines or blocks for the elements you WANT to see */

        /* home page color */
        @-moz-document url("about:home"),
                       url("about:newtab") {
          body[lwt-newtab-brighttext] {
            --newtab-background-color: #181818 !important;
          }
        }

        /* Menu button */
        #PanelUI-button {
          -moz-box-ordinal-group: 0 !important;
          order: -2 !important;
          margin: 2px !important;
          /* display: none !important; /* uncomment this line to hide the menu button */
        }

        /* Window control buttons (min, resize and close) */
        .titlebar-buttonbox-container {
          display: none !important;
          margin-right: 12px !important;
        }

        /* Page back and foward buttons */
        #back-button,
        #forward-button
        {
          display: none !important
        }

        /* Extensions button */
        #unified-extensions-button {
          display: none !important
        }

        /* Extension name inside URL bar */
        #identity-box.extensionPage #identity-icon-label {
          visibility: collapse !important
        }

        /* All tabs (v-like) button */
        #alltabs-button {
          display: none !important
        }

        /* URL bar icons */
        #identity-permission-box,
        #star-button-box,
        #identity-icon-box,
        #picture-in-picture-button,
        #tracking-protection-icon-container,
        #reader-mode-button,
        #translations-button
        {
          display: none !important
        }

        /* "This time search with:..." */
        #urlbar .search-one-offs {
          display: none !important
        }

        /* Space before and after tabs */
        .titlebar-spacer {
          display: none;
        }

        /* --- ~END~ element visibility section --- */

        /* Navbar size calc */
        :root{
        --tab-border-radius: 6px !important; /*  Tab border radius -- Changes the tabs rounding  *//*  Default: 6px  */
        --NavbarWidth: 43; /*  Default values: 36 - 43  */
        --TabsHeight: 36; /*  Minimum: 30  *//*  Default: 36  */
        --TabsBorder: 8; /*  Doesnt do anything on small layout  *//*  Default: 8  */
        --NavbarHeightSmall: calc(var(--TabsHeight) + var(--TabsBorder))  /*  Only on small layout  *//*  Default: calc(var(--TabsHeight) + var(--TabsBorder))  *//*  Default as a number: 44  */}

        @media screen and (min-width:1325px)    /*  Only the tabs space will grow from here  */
        {:root #nav-bar{margin-top: calc(var(--TabsHeight) * -1px - var(--TabsBorder) * 1px)!important; height: calc(var(--TabsHeight) * 1px + var(--TabsBorder) * 1px)} #TabsToolbar{margin-left: calc(1325px / 100 * var(--NavbarWidth)) !important} #nav-bar{margin-right: calc(100vw - calc(1325px / 100 * var(--NavbarWidth))) !important; vertical-align: center !important} #urlbar-container{min-width: 0px !important;  flex: auto !important} toolbarspring{display: none !important}}

        @media screen and (min-width:950px) and (max-width:1324px)    /*  Both the tabs space and the navbar will grow  */
        {:root #nav-bar{margin-top: calc(var(--TabsHeight) * -1px - var(--TabsBorder) * 1px) !important; height: calc(var(--TabsHeight) * 1px + var(--TabsBorder) * 1px)} #TabsToolbar{margin-left: calc(var(--NavbarWidth) * 1vw) !important} #nav-bar{margin-right: calc(100vw - calc(var(--NavbarWidth) * 1vw)) !important; vertical-align: center !important} #urlbar-container{min-width: 0px !important;  flex: auto !important} toolbarspring{display: none !important} #TabsToolbar, #nav-bar{transition: margin-top .25s !important}}

        @media screen and (max-width:949px)    /*  The window is not enough wide for a one line layout  */
        {:root #nav-bar{padding: 0 5px 0 5px!important; height: calc(var(--NavbarHeightSmall) * 1px) !important} toolbarspring{display: none !important;} #TabsToolbar, #nav-bar{transition: margin-top .25s !important}}
        #nav-bar, #PersonalToolbar{background-color: #0000 !important;background-image: none !important; box-shadow: none !important} #nav-bar{margin-left: 3px;} .tab-background, .tab-stack { min-height: calc(var(--TabsHeight) * 1px) !important}

        /*  Removes urlbar border/background  */
        #urlbar-background {
          border: none !important;
          outline: none !important;
          transition: .15s !important;
        }

        /*  Removes the background from the urlbar while not in use  */
        #urlbar:not(:hover):not([breakout][breakout-extend]) > #urlbar-background {
          box-shadow: none !important;
          background: #0000 !important;
        }

        /*  Removes annoying border  */
        #navigator-toolbox {
          border: none !important
        }

        /* Fades window while not in focus */
        #navigator-toolbox-background:-moz-window-inactive {
          filter: contrast(90%)
        }

        /* Remove fullscreen warning border */
        #fullscreen-warning {
          border: none !important;
          background: -moz-Dialog !important;
        }

        /*  Tabs close button  */
        .tabbrowser-tab:not(:hover) .tab-close-button {
          opacity: 0% !important;
          transition: 0.3s !important;
          display: -moz-box !important;
        }
        .tab-close-button[selected]:not(:hover) {
          opacity: 45% !important;
          transition: 0.3s !important;
          display: -moz-box !important;
        }
        .tabbrowser-tab:hover .tab-close-button {
          opacity: 50%;
          transition: 0.3s !important;
          background: none !important;
          cursor: pointer;
          display: -moz-box !important;
        }
        .tab-close-button:hover {
          opacity: 100% !important;
          transition: 0.3s !important;
          background: none !important;
          cursor: pointer;
          display: -moz-box !important;
        }
        .tab-close-button[selected]:hover {
          opacity: 100% !important;
          transition: 0.3s !important;
          background: none !important;
          cursor: pointer;
          display: -moz-box !important;
        }
      '';

      userContent = ''
        /* home page color */
        @-moz-document url("about:home"), url("about:newtab") {
            body {
                background-color: #181818 !important;
            }
        }
      '';
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };
}
