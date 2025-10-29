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
	"toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "layout.css.color-mix.enabled" = true;
	"browser.tabs.drawInTitlebar" = true;

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

	# ========== CLEANING ON CLOSE ==========
	"privacy.sanitize.sanitizeOnShutdown" = true;
        "privacy.clearOnShutdown.cache" = true;
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.formData" = true;
        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown.sessions" = true;
        "privacy.clearOnShutdown.cookies" = true;
        "privacy.clearOnShutdown.offlineApps" = true;
        "privacy.clearOnShutdown.siteSettings" = true;
	"privacy.clearOnShutdown.extensions" = false;
	"privacy.clearOnShutdown.extensions-settings" = false;
        
        # What to clear (enable all)
        "privacy.cpd.cache" = true;
        "privacy.cpd.downloads" = true;
        "privacy.cpd.formData" = true;
        "privacy.cpd.history" = true;
        "privacy.cpd.sessions" = true;
        "privacy.cpd.cookies" = true;
        "privacy.cpd.offlineApps" = true;
        "privacy.cpd.siteSettings" = true;        

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
	"extensions.webextensions.restrictedDomains" = "";
	"extensions.experiments.enabled" = true;

      	};
	extensions = {
		packages = with pkgs.nur.repos.rycee.firefox-addons; [
    		ublock-origin
		darkreader
		sponsorblock
		h264ify
		firefox-color
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
		default = "ddg-html";
      		force = true;
      
      engines = {
        "ddg-html" = {
          urls = [{
            template = "https://html.duckduckgo.com/html/";
            params = [
              { name = "q"; value = "{searchTerms}"; }
            ];
          }];
          definedAliases = [ "@ddg" "@html" ];
        };
	"ddg" = {
          urls = [{
            template = "https://duckduckgo.com/";
            params = [
              { name = "q"; value = "{searchTerms}"; }
            ];
          }];
          definedAliases = [ "@ddg-js" ];
        };
          };
        };
      };
    };
  };
}
