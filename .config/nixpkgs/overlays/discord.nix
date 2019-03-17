self: super:
let
  fetchurl = super.pkgs.fetchurl;
in
{
  discord = super.discord.overrideDerivation (old: rec {
    version = "0.0.9";
    src = fetchurl {
      url = "https://cdn.discordapp.com/apps/linux/${version}/${super.discord.pname}-${version}.tar.gz";
      sha256 = "1i0f8id10rh2fx381hx151qckvvh8hbznfsfav8w0dfbd1bransf";
    };
  });
}
