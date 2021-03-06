intf_libs = # Interface dependencies.
impl_libs = # Implementation dependencies.
import intf_libs += plf-nanotimer%lib{nanotimer}

src_upstream = $src_root/upstream

./ : $src_upstream/doc{README.md} manifest

./ : lib{rand} exe{bench}

lib{rand} : $src_upstream/hxx{**} $impl_libs $intf_libs

# Build options.
#
cxx.poptions =+ "-I$out_root/upstream" "-I$src_root/upstream"

# Export options.
#
lib{rand}:
{
  cxx.export.poptions = "-I$out_root/upstream" "-I$src_root/upstream"
  cxx.export.libs = $intf_libs
}

# Install recreating subdirectories.
#
{hxx ixx txx}{*}:
{
  install         = include/
  install.subdirs = false
}


## Test/Benchmark

exe{bench} : $src_upstream/cxx{**} lib{rand}
exe{bench} :
{
  test = true
  install = false
}
