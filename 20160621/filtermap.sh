#!/bin/bash
#$ -l ram.c=7.5G,h_rt=12:00:00
#$ -pe pe_slots 16
#$ -cwd
#$ -m e 
#$ -M arrivers@lbl.gov


module load bbtools
module load pigz

#Do adapter trimming and contaminant removal on the 4 mock viral libraries
#VARIABLES
BAYTB="/global/dna/dm_archive/sdm/illumina/01/05/98/10598.1.166606.ATGTC.fastq.gz"
BAYTC="/global/dna/dm_archive/sdm/illumina/01/05/98/10598.1.166606.CCGTC.fastq.gz"
BAYTG="/global/dna/dm_archive/sdm/illumina/01/05/98/10598.1.166606.GTCCG.fastq.gz"
BAYTH="/global/dna/dm_archive/sdm/illumina/01/05/98/10598.1.166606.GTGAA.fastq.gz"


#mkdir results
#mkdir sam

#Threads
$THREADS=16

rqcfilter.sh in=$BAYTB \
path=BAYTB  library=frag rna=f threads=16 pigz=t unpigz=t phix=f removehuman=t removedog=t removecat=t removemouse=t threads=$THREADS qtrim=t removemicrobes=t

rqcfilter.sh in=$BAYTC \
path=BAYTC  library=frag rna=f threads=16 pigz=t unpigz=t phix=f removehuman=t removedog=t removecat=t removemouse=t threads=$THREADS qtrim=t removemicrobes=t

rqcfilter.sh in=$BAYTG \
path=BAYTG  library=frag rna=f threads=16 pigz=t unpigz=t phix=f removehuman=t removedog=t removecat=t removemouse=t threads=$THREADS qtrim=t removemicrobes=t

rqcfilter.sh in=$BAYTH \
path=BAYTH  library=frag rna=f threads=16 pigz=t unpigz=t phix=f removehuman=t removedog=t removecat=t removemouse=t threads=$THREADS qtrim=t removemicrobes=t


#BBmerge
bbmerge.sh in=BAYTB/10598.1.166606.ATGTC.anqdht.fastq.gz out=BAYTB/10598.1.166606.ATGTC.anqdht.merged.fastq.gz outu=BAYTB/10598.1.166606.ATGTC.anqdht.unmerged.fastq.gz
bbmerge.sh in=BAYTC/10598.1.166606.CCGTC.anqdht.fastq.gz out=BAYTC/10598.1.166606.CCGTC.anqdht.merged.fastq.gz outu-BAYTC/10598.1.166606.CCGTC.anqdht.unmerged.fastq.gz
bbmerge.sh in=BAYTG/10598.1.166606.GTCCG.anqdht.fastq.gz out=BAYTG/10598.1.166606.GTCCG.anqdht.merged.fastq.gz outu=BAYTG/10598.1.166606.GTCCG.anqdht.unmerged.fastq.gz
bbmerge.sh in=BAYTG/10598.1.166606.GTCCG.anqdht.fastq.gz out=BAYTG/10598.1.166606.GTCCG.anqdht.merged.fastq.gz outu=BAYTG/10598.1.166606.GTCCG.anqdht.unmerged.fastq.gz


#BAYTB 
bbmap.sh nodisk=t ref=../refs/PSA-HM1.fna usejni=t unpigz=t threads=$THREADS in=BAYTB/10598.1.166606.ATGTC.anqdht.fastq.gz ihist=results/PSA-HM1-BAYTB-hist.txt out=sam/PSA-HM1-BAYTB.sam
bbmap.sh nodisk=t ref=../refs/PSA-HP1.fna usejni=t unpigz=t threads=$THREADS in=BAYTB/10598.1.166606.ATGTC.anqdht.fastq.gz ihist=results/PSA-HP1-BAYTB-hist.txt out=sam/PSA-HP1-BAYTB.sam
bbmap.sh nodisk=t ref=../refs/PSA-HS2.fna usejni=t unpigz=t threads=$THREADS in=BAYTB/10598.1.166606.ATGTC.anqdht.fastq.gz ihist=results/PSA-HS2-BAYTB-hist.txt out=sam/PSA-HS2-BAYTB.sam
bbmap.sh nodisk=t ref=../refs/phix_Ref_database.fna usejni=t unpigz=t threads=$THREADS in=BAYTB/10598.1.166606.ATGTC.anqdht.fastq.gz ihist=results/phix-BAYTB-hist.txt out=sam/phix-BAYTB.sam
bbmap.sh nodisk=t ref=../refs/alpha3_ref_database.fna usejni=t unpigz=t threads=$THREADS in=BAYTB/10598.1.166606.ATGTC.anqdht.fastq.gz ihist=results/alpha3-BAYTB-hist.txt out=sam/alpha3-BAYTB.sam
bbmap.sh nodisk=t ref=../refs/Ref_database.fna usejni=t unpigz=t threads=$THREADS in=BAYTB/10598.1.166606.ATGTC.anqdht.fastq.gz outu=sam/unmapped-BAYTB.sam
#BAYTC
bbmap.sh nodisk=t ref=../refs/PSA-HM1.fna usejni=t unpigz=t threads=$THREADS in=BAYTC/10598.1.166606.CCGTC.anqdht.fastq.gz ihist=results/PSA-HM1-BAYTC-hist.txt out=sam/PSA-HM1-BAYTC.sam
bbmap.sh nodisk=t ref=../refs/PSA-HP1.fna usejni=t unpigz=t threads=$THREADS in=BAYTC/10598.1.166606.CCGTC.anqdht.fastq.gz ihist=results/PSA-HP1-BAYTC-hist.txt out=sam/PSA-HP1-BAYTC.sam
bbmap.sh nodisk=t ref=../refs/PSA-HS2.fna usejni=t unpigz=t threads=$THREADS in=BAYTC/10598.1.166606.CCGTC.anqdht.fastq.gz ihist=results/PSA-HS2-BAYTC-hist.txt out=sam/PSA-HS2-BAYTC.sam
bbmap.sh nodisk=t ref=../refs/phix_Ref_database.fna usejni=t unpigz=t threads=$THREADS in=BAYTC/10598.1.166606.CCGTC.anqdht.fastq.gz ihist=results/phix-BAYTC-hist.txt out=sam/phix-BAYTC.sam
bbmap.sh nodisk=t ref=../refs/alpha3_ref_database.fna usejni=t unpigz=t threads=$THREADS in=BAYTC/10598.1.166606.CCGTC.anqdht.fastq.gz ihist=results/alpha3-BAYTC-hist.txt out=sam/alpha3-BAYTC.sam
bbmap.sh nodisk=t ref=../refs/Ref_database.fna usejni=t unpigz=t threads=$THREADS in=BAYTC/10598.1.166606.CCGTC.anqdht.fastq.gz outu=sam/unmapped-BAYTC.sam
#BAYTG 
bbmap.sh nodisk=t ref=../refs/PSA-HM1.fna usejni=t unpigz=t threads=$THREADS in=BAYTG/10598.1.166606.GTCCG.anqdht.fastq.gz ihist=results/PSA-HM1-BAYTG-hist.txt out=sam/PSA-HM1-BAYTG.sam
bbmap.sh nodisk=t ref=../refs/PSA-HP1.fna usejni=t unpigz=t threads=$THREADS in=BAYTG/10598.1.166606.GTCCG.anqdht.fastq.gz ihist=results/PSA-HP1-BAYTG-hist.txt out=sam/PSA-HP1-BAYTG.sam
bbmap.sh nodisk=t ref=../refs/PSA-HS2.fna usejni=t unpigz=t threads=$THREADS in=BAYTG/10598.1.166606.GTCCG.anqdht.fastq.gz ihist=results/PSA-HS2-BAYTG-hist.txt out=sam/PSA-HS2-BAYTG.sam
bbmap.sh nodisk=t ref=../refs/phix_Ref_database.fna usejni=t unpigz=t threads=$THREADS in=BAYTG/10598.1.166606.GTCCG.anqdht.fastq.gz ihist=results/phix-BAYTG-hist.txt out=sam/phix-BAYTG.sam
bbmap.sh nodisk=t ref=../refs/alpha3_ref_database.fna usejni=t unpigz=t threads=$THREADS in=BAYTG/10598.1.166606.GTCCG.anqdht.fastq.gz ihist=results/alpha3-BAYTG-hist.txt out=sam/alpha3-BAYTG.sam
bbmap.sh nodisk=t ref=../refs/Ref_database.fna usejni=t unpigz=t threads=$THREADS in=BAYTG/10598.1.166606.GTCCG.anqdht.fastq.gz outu=sam/unmapped-BAYTG.sam
#BAYTH 
bbmap.sh nodisk=t ref=../refs/PSA-HM1.fna usejni=t unpigz=t threads=$THREADS in=BAYTH/10598.1.166606.GTGAA.anqdht.fastq.gz ihist=results/PSA-HM1-BAYTH-hist.txt out=sam/PSA-HM1-BAYTH.sam
bbmap.sh nodisk=t ref=../refs/PSA-HP1.fna usejni=t unpigz=t threads=$THREADS in=BAYTH/10598.1.166606.GTGAA.anqdht.fastq.gz ihist=results/PSA-HP1-BAYTH-hist.txt out=sam/PSA-HP1-BAYTH.sam
bbmap.sh nodisk=t ref=../refs/PSA-HS2.fna usejni=t unpigz=t threads=$THREADS in=BAYTH/10598.1.166606.GTGAA.anqdht.fastq.gz ihist=results/PSA-HS2-BAYTH-hist.txt out=sam/PSA-HS2-BAYTH.sam
bbmap.sh nodisk=t ref=../refs/phix_Ref_database.fna usejni=t unpigz=t threads=$THREADS in=BAYTH/10598.1.166606.GTGAA.anqdht.fastq.gz ihist=results/phix-BAYTH-hist.txt  out=sam/phix-BAYTH.sam
bbmap.sh nodisk=t ref=../refs/alpha3_ref_database.fna usejni=t unpigz=t threads=$THREADS in=BAYTH/10598.1.166606.GTGAA.anqdht.fastq.gz ihist=results/alpha3-BAYTH-hist.txt out=sam/alpha3-BAYTH.sam
bbmap.sh nodisk=t ref=../refs/Ref_database.fna usejni=t unpigz=t threads=$THREADS in=BAYTH/10598.1.166606.GTGAA.anqdht.fastq.gz outu=sam/unmapped-BAYTH.sam