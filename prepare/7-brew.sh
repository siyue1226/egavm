#!/usr/bin/env bash

echo "====> Linuxbrew environment  <===="

echo "==> Clone latest linuxbrew"
git clone https://github.com/Homebrew/linuxbrew.git $HOME/.linuxbrew

if grep -q -i linuxbrew $HOME/.bashrc; then
    echo "==> .bashrc already contains linuxbrew"
else
    echo "==> Update .bashrc"

    LB_PATH='export PATH="$HOME/.linuxbrew/bin:$PATH"'
    LB_MAN='export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"'
    LB_INFO='export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"'
    echo '# Linuxbrew' >> $HOME/.bashrc
    echo $LB_PATH >> $HOME/.bashrc
    echo $LB_MAN  >> $HOME/.bashrc
    echo $LB_INFO >> $HOME/.bashrc
    echo >> $HOME/.bashrc

    eval $LB_PATH
    eval $LB_MAN
    eval $LB_INFO
fi

#echo "==> Check brew with doctor"
#brew doctor

echo "==> Add tap science"
brew tap homebrew/science

# Many bioinfomatics hosted on low band server, so don't waste time on downloading them repeatedly.
mkdir -p $HOME/.cache/Homebrew
rm $HOME/.cache/Homebrew/*.incomplete
cp /prepare/resource/ncbi-blast-2.2.31+src.tar.gz           $HOME/.cache/Homebrew/blast-2.2.31.tar.gz
cp /prepare/resource/bzip2-1.0.6.tar.gz                     $HOME/.cache/Homebrew/bzip2-1.0.6.tar.gz
cp /prepare/resource/clustalw-2.1.tar.gz                    $HOME/.cache/Homebrew/clustal-w-2.1.tar.gz
cp /prepare/resource/hmmer-3.1b2.tar.gz                     $HOME/.cache/Homebrew/hmmer-3.1b2.tar.gz
cp /prepare/resource/jpegsrc.v8d.tar.gz                     $HOME/.cache/Homebrew/jpeg-8d.tar.gz
cp /prepare/resource/lastz-1.02.00.tar.gz                   $HOME/.cache/Homebrew/lastz-1.02.00.tar.gz
cp /prepare/resource/mafft-7.221-with-extensions-src.tgz    $HOME/.cache/Homebrew/mafft-7.221.tgz
cp /prepare/resource/ncbi-rmblastn-2.2.28-x64-linux.tar.gz  $HOME/.cache/Homebrew/ncbi-rmblastn-2.2.28-x64-linux.tar.gz
cp /prepare/resource/node-v0.12.7.tar.gz                    $HOME/.cache/Homebrew/node-0.12.7.tar.gz
cp /prepare/resource/pcre-8.37.tar.bz2                      $HOME/.cache/Homebrew/pcre-8.37.tar.bz2
cp /prepare/resource/pkg-config-0.28.tar.gz                 $HOME/.cache/Homebrew/pkg-config-0.28.tar.gz
cp /prepare/resource/standard-RAxML-8.1.15.tar.gz           $HOME/.cache/Homebrew/raxml-8.1.15.tar.gz
cp /prepare/resource/newick-utils-1.6.tar.gz                $HOME/.cache/Homebrew/newick-utils-1.6.tar.gz
cp /prepare/resource/RepeatMasker-open-4-0-5.tar.gz         $HOME/.cache/Homebrew/repeatmasker-4.0.5.tar.gz
cp /prepare/resource/xz-5.2.1.tar.gz                        $HOME/.cache/Homebrew/xz-5.2.1.tar.gz

echo "==> Install bioinfomatics softwares"
brew install clustal-w hmmer lastz mafft newick-utils raxml
brew install blast --without-check # this will not install boost
brew install rmblast --without-blast
brew install repeatmasker --without-configure # run config later

echo "==> Install vcftools"
brew install vcftools
cp $HOME/.linuxbrew/lib/perl5/site_perl/FaSlice.pm  `perl -e 'print grep {/site_perl/} grep {!/x86_64/} @INC'`
cp $HOME/.linuxbrew/lib/perl5/site_perl/Vcf.pm      `perl -e 'print grep {/site_perl/} grep {!/x86_64/} @INC'`
cp $HOME/.linuxbrew/lib/perl5/site_perl/VcfStats.pm `perl -e 'print grep {/site_perl/} grep {!/x86_64/} @INC'`
