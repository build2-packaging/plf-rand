intf_libs = # Interface dependencies.
impl_libs = # Implementation dependencies.
#import impl_libs += libhello%lib{hello}

./: lib{plf-rand} doc{README.md} manifest

lib{plf-rand}: {hxx ixx txx cxx}{**} $impl_libs $intf_libs

# Build options.
#
cxx.poptions =+ "-I$out_root" "-I$src_root"

obja{*}: cxx.poptions += -DPLF_RAND_STATIC_BUILD
objs{*}: cxx.poptions += -DPLF_RAND_SHARED_BUILD

# Export options.
#
lib{plf-rand}:
{
  cxx.export.poptions = "-I$out_root" "-I$src_root"
  cxx.export.libs = $intf_libs
}

liba{plf-rand}: cxx.export.poptions += -DPLF_RAND_STATIC
libs{plf-rand}: cxx.export.poptions += -DPLF_RAND_SHARED

# For pre-releases use the complete version to make sure they cannot be used
# in place of another pre-release or the final version. See the version module
# for details on the version.* variable values.
#
if $version.pre_release
  lib{plf-rand}: bin.lib.version = @"-$version.project_id"
else
  lib{plf-rand}: bin.lib.version = @"-$version.major.$version.minor"

# Install recreating subdirectories.
#
{hxx ixx txx}{*}:
{
  install         = include/
  install.subdirs = true
}
