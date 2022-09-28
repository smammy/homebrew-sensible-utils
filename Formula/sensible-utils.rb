# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class SensibleUtils < Formula
  desc "Utilities for sensible alternative selection"
  homepage "https://salsa.debian.org/debian/sensible-utils"
  url "https://salsa.debian.org/debian/sensible-utils/-/archive/debian/0.0.17/sensible-utils-debian-0.0.17.tar.bz2"
  sha256 "6059853f36e7090f5d20e0b45a888d6b4252e0c94eefa9fc22ad688e32be5282"
  license "GPL-2.0-or-later"

  depends_on "gettext" => :build
  depends_on "po4a" => :build
  
  patch :DATA

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    configure_args = std_configure_args - ["--disable-debug", "--disable-dependency-tracking"]
    system "./configure", *configure_args, "--disable-silent-rules"
    system "make install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test sensible-utils`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
__END__
diff --git a/sensible-browser b/sensible-browser
--- a/sensible-browser
+++ b/sensible-browser
@@ -40,6 +40,8 @@ elif test -x /usr/bin/www-browser; then
     exec /usr/bin/www-browser "$@"
 fi
 
+Run open -u "$@" && exit "$ret"
+
 echo "Couldn't find a suitable web browser!\n" >&2
 echo "Set the BROWSER environment variable to your desired browser.\n" >&2
 exit 1;
diff --git a/sensible-editor b/sensible-editor
--- a/sensible-editor
+++ b/sensible-editor
@@ -45,9 +45,7 @@ if [ -n "$HOME" ]; then
     fi
 fi
 
-Run ${EDITOR:-${SELECTED_EDITOR:-editor}} "$@" ||
-Run nano "$@" ||
-Run nano-tiny "$@" ||
+Run ${EDITOR:-${SELECTED_EDITOR:-nano}} "$@" ||
 Run vi "$@" ||
 {
 	echo "Couldn't find an editor!" 1>&2
diff --git a/sensible-pager b/sensible-pager
--- a/sensible-pager
+++ b/sensible-pager
@@ -18,8 +18,7 @@ Run()
 	IsError "$ret"
 }
 
-Run ${PAGER:-pager} "$@" ||
-Run more "$@" ||
+Run ${PAGER:-more "$@" ||
 {
 		echo "Couldn't find a pager!" 1>&2
 		echo "Set the \$PAGER environment variable to your desired pager." 1>&2
