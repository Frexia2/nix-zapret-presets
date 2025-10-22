{ config, pkgs, ... }:

{
programs.firefox = {
      enable = true;
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
          settings = {
#	========== GENERAL SETTINGS ==========
	# Theming
	"browser.display.background_color" = "#191724";
	"browser.display.foreground_color" = "#e0def4";
	"browser.anchor_color" = "#9ccfd8";
	"browser.visited_color" = "#c4a7e7";
	"reader.color_scheme" = "dark";
	"reader.content_color" = "#e0def4";
	"reader.bg_color" = "#191724";
	"devtools.theme" = "dark";
	"toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "ui.systemUsesDarkTheme" = 1;
        "browser.theme.toolbar-theme" = 0; # Dark toolbar
	# Searching
        "browser.search.defaultenginename" = "ddg";
        "browser.search.order.1" = "ddg";
	# Misc.
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "browser.aboutConfig.showWarning" = false;
        "browser.compactmode.show" = true;
        "browser.cache.disk.enable" = false;

        "mousewheel.default.delta_multiplier_x" = 20;
        "mousewheel.default.delta_multiplier_y" = 20;
        "mousewheel.default.delta_multiplier_z" = 20;

	"widget.disable-workspace-management" = true;

        # ========== TELEMETRY & DATA COLLECTION ==========
        # Disable all telemetry
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        
        # Disable health report
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.policy.dataSubmissionPolicyBypassNotification" = false;
        
        # Disable experiments
        "experiments.supported" = false;
        "experiments.enabled" = false;
        "experiments.manifest.uri" = "";
        
        # ========== CRASH REPORTING ==========
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.enabled" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        
        # ========== SPONSORED CONTENT & ADS ==========
        # New tab page sponsored content
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        
        # Search and URL bar sponsored suggestions
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.quicksuggest.shouldShowOnboardingDialog" = false;
        "browser.urlbar.groupLabels.enabled" = false;
        "browser.urlbar.resultGroups" = "";
        
        # ========== POCKET & INTEGRATIONS ==========
        "extensions.pocket.enabled" = false;
        "extensions.pocket.oAuthConsumerKey" = "";
        "extensions.pocket.api" = "";
	"extensions.pocket.site" = "";

        # ========== SAFE BROWSING (privacy vs security trade-off) ==========
        # Comment these out if you want safe browsing protection
#        "browser.safebrowsing.malware.enabled" = false;
#        "browser.safebrowsing.phishing.enabled" = false;
#        "browser.safebrowsing.downloads.enabled" = false;
#        "browser.safebrowsing.downloads.remote.enabled" = false;
#        "browser.safebrowsing.blockedURIs.enabled" = false;
#        "browser.safebrowsing.provider.google4.dataSharing.enabled" = false;
        
        # ========== FORM & PASSWORD AUTOFILL ==========
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;
        "signon.formlessCapture.enabled" = false;
        
        # ========== LOCATION & SEARCH SUGGESTIONS ==========
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.topsites" = false;

	# ========== NOTIFICATIONS & PERMISSIONS ==========
        "permissions.default.geo" = 2; # 2=block, 1=allow, 0=ask
        "permissions.default.camera" = 2;
        "permissions.default.microphone" = 2;
        "permissions.default.desktop-notification" = 2;
        "dom.webnotifications.enabled" = false;
        "geo.enabled" = false;
        
        # ========== WEBSITE BEHAVIOR ==========
        "dom.battery.enabled" = false;
        "media.navigator.enabled" = false;
        "media.peerconnection.enabled" = false; # WebRTC
        "webgl.disabled" = false; # Set to true if you want to disable WebGL
        
        # ========== CACHING & STORAGE ==========
        "browser.cache.offline.enable" = false;
        "browser.shell.shortcutFavicons" = false;
        
        # ========== MISCELLANEOUS PRIVACY ==========
        "browser.send_pings" = false;
        "browser.sessionstore.privacy_level" = 2; # 0=all data, 2=minimal data
        "network.http.referer.trimmingPolicy" = 2; # 2=send only scheme+host
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "network.http.sendSecureXSiteReferrer" = false;
        
        # ========== STARTUP & HOMEPAGE ==========
        "browser.startup.homepage" = "about:blank";
        "browser.newtabpage.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
        
        # ========== UPDATES ==========
        "app.update.auto" = false;
        "app.update.enabled" = false;
        "app.update.silent" = false;
        "app.update.staging.enabled" = false;
        
        # ========== PREFETCHING ==========
        "network.dns.disablePrefetch" = true;
        "network.predictor.enabled" = false;
        "network.prefetch-next" = false;
        "network.http.speculative-parallel-limit" = 0;
        
        # ========== FINGERPRINTING PROTECTION ==========
        # Note: This may break some websites
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        
        # ========== CONTENT BLOCKING ==========
        "browser.contentblocking.category" = "strict"; # "standard", "strict", "custom"
        "privacy.annotate_channels.strict_list.enabled" = true;
        "privacy.partition.serviceWorkers" = true;
        "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
        
        # ========== HTTPS-ONLY MODE ==========
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;
	# ========== EXTENSIONS MANAGMENT ==========
	"extensions.autoDisableScopes" = 0;

	userChrome = ''
        /* Rose Pine Color Scheme - Main Palette */
        :root {
          /* Base Colors */
          --base: #191724;
          --surface: #1f1d2e;
          --overlay: #26233a;
          --muted: #6e6a86;
          --subtle: #908caa;
          --text: #e0def4;
          --love: #eb6f92;
          --gold: #f6c177;
          --rose: #ebbcba;
          --pine: #31748f;
          --foam: #9ccfd8;
          --iris: #c4a7e7;
          --highlight-low: #21202e;
          --highlight-med: #403d52;
          --highlight-high: #524f67;
        }

        /* Apply to main browser UI */
        #navigator-toolbox {
          background: var(--base) !important;
          color: var(--text) !important;
          border-bottom: 1px solid var(--overlay) !important;
        }

        /* Toolbar */
        #nav-bar {
          background: var(--base) !important;
          color: var(--text) !important;
          border-bottom: 1px solid var(--overlay) !important;
        }

        /* Tabs */
        .tabbrowser-tab {
          color: var(--text) !important;
        }

        .tab-background {
          background: var(--surface) !important;
          border: 1px solid var(--overlay) !important;
          margin: 2px 1px !important;
          border-radius: 6px !important;
        }

        .tabbrowser-tab[selected] .tab-background {
          background: var(--overlay) !important;
          border-color: var(--pine) !important;
        }

        .tab-line {
          background: var(--pine) !important;
        }

        /* URL Bar */
        #urlbar {
          background: var(--surface) !important;
          color: var(--text) !important;
          border: 1px solid var(--overlay) !important;
          border-radius: 8px !important;
        }

        #urlbar:hover {
          background: var(--overlay) !important;
          border-color: var(--highlight-med) !important;
        }

        #urlbar[focused] {
          border-color: var(--pine) !important;
          box-shadow: 0 0 0 1px var(--pine) !important;
        }

        /* Sidebar */
        #sidebar-box {
          background: var(--base) !important;
          color: var(--text) !important;
        }

        sidebarheader {
          background: var(--surface) !important;
          color: var(--text) !important;
          border-bottom: 1px solid var(--overlay) !important;
        }

        /* Bookmarks Toolbar */
        #PersonalToolbar {
          background: var(--surface) !important;
          border-top: 1px solid var(--overlay) !important;
        }

        /* Buttons */
        toolbarbutton {
          color: var(--text) !important;
          background: transparent !important;
          border: none !important;
        }

        toolbarbutton:hover {
          background: var(--overlay) !important;
          border-radius: 4px !important;
        }

        /* Menu */
        menupopup {
          background: var(--surface) !important;
          color: var(--text) !important;
          border: 1px solid var(--overlay) !important;
          border-radius: 8px !important;
        }

        menuitem, menu {
          color: var(--text) !important;
        }

        menuitem:hover, menu:hover {
          background: var(--overlay) !important;
        }

        /* Scrollbars */
        scrollbar {
          background: var(--base) !important;
        }

        scrollbarthumb {
          background: var(--overlay) !important;
          border-radius: 8px !important;
        }

        scrollbarthumb:hover {
          background: var(--highlight-med) !important;
        }
	
	/* Find Bar */
        findbar {
          background: var(--base) !important;
          color: var(--text) !important;
          border-top: 1px solid var(--overlay) !important;
        }

        /* Progress indicator */
        .tab-progress {
          background: var(--pine) !important;
        }
      '';
      
      userContent = ''
        /* Optional: Apply Rose Pine to web content scrollbars */
        :root {
          scrollbar-color: var(--overlay) var(--base);
        }

        /* Style selection text */
        ::selection {
          background: var(--pine) !important;
          color: var(--text) !important;
        }
      '';
          };
	extensions = {
		packages = with pkgs.nur.repos.rycee.firefox-addons; [
    		ublock-origin
		darkreader
		sponsorblock
		h264ify
  		];
	};

  settings."uBlock0@raymondhill.net".settings = {
    selectedFilterLists = [
      "ublock-filters"
      "ublock-badware"
      "ublock-privacy"
      "ublock-unbreak"
      "ublock-quick-fixes"
    ];
  };
	search = {
		force = true;
		default = "ddg";
		order = [ "ddg" ];
          };
        };
      };
    };
}
