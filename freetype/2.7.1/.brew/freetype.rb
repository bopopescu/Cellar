class Freetype < Formula
  desc "Software library to render fonts"
  homepage "https://www.freetype.org/"
  url "https://downloads.sf.net/project/freetype/freetype2/2.7.1/freetype-2.7.1.tar.bz2"
  mirror "https://download.savannah.gnu.org/releases/freetype/freetype-2.7.1.tar.bz2"
  sha256 "3a3bb2c4e15ffb433f2032f50a5b5a92558206822e22bfe8cbe339af4aa82f88"

  keg_only :provided_pre_mountain_lion

  option :universal
  option "without-subpixel", "Disable sub-pixel rendering (a.k.a. LCD rendering, or ClearType)"

  depends_on "libpng"

  def install
    if build.with? "subpixel"
      inreplace "include/freetype/config/ftoption.h",
          "/* #define FT_CONFIG_OPTION_SUBPIXEL_RENDERING */",
          "#define FT_CONFIG_OPTION_SUBPIXEL_RENDERING"
    end

    ENV.universal_binary if build.universal?
    system "./configure", "--prefix=#{prefix}", "--without-harfbuzz"
    system "make"
    system "make", "install"

    inreplace [bin/"freetype-config", lib/"pkgconfig/freetype2.pc"],
      prefix, opt_prefix
  end

  test do
    system bin/"freetype-config", "--cflags", "--libs", "--ftversion",
                                  "--exec-prefix", "--prefix"
  end
end