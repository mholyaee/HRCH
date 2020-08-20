# HRCH
This code is related to our recently proposed method called HRCH. This method can solve single individual haplotype problem for the both diploid and polyploid organisms
## Requirement:
1) This program is suitable for MATLAB R2013a and above versions. The program has adopted by Geraci's dataset. By some little change it can be used for any input data.
2) Please download the software fpgrowth.exe from the below link; it can mine frequent item sets.
http://www.borgelt.net/fpgrowth.html 
3) Please download the software hmetis.exe. It was used for partitioning hypergraphs: http://glaros.dtc.umn.edu/gkhome/metis/hmetis/download

 We used hmetis-1.5.3-WIN32.zip.

Finally, please save them in the same folder with this program, and modify the file path in the program.

## Running the method
Please call the functions with this order:
1) HGHapCut_mec_RAX
2) newConfidRahman
3) callFillGapsDiploid

## The first function can be called in two forms:

### 1) Without any input arguments

In this form, The function will be executed on the Geraci's dataset as defualt. In addition, the obtained results including the reconstruction rate(RR),running time and the output haplotypes will be saved in some text files on the current path.

### 2) Call with input arguments

In this case, the user can run the program for a specified matrix fragments. The call function template is as follow:

HGHapCut_mec_RAX('Sim0','TargetHaps')

Which 'Sim0' is a filename contaning the matrix fragment and 'TargetHaps' is a file which involves the target haplotypes.
It should be noted that their formats must be comaptible with Geraci's benchmark (Please see Sim0 and TargetHaps files).

The next functions are related to the second phase. The input file should include haplotpes with long length. By calling the second function i.e. 'newConfidRahman', the obtained haplotypes are compared with the corresponding fragment matrix and for each loci, a confidence measure is computed.

Finally, by calling 'CallFillGapsDiploid' function, for each loci of the resulted haplotypes which its confidence is lower than a predefined treshold, its measure is rectified based on chaos game representation.

It should be noted that this function is called without any input argument; the output haplotypes as well as its confidence measure which were loaded from seperate files, are used to improve the locis with low confidences.


### The details of the used dataset can be accessible in the below paper:

F. Geraci, "A comparison of several algorithms for the single individual SNP haplotyping reconstruction problem," Bioinformatics, vol. 26, pp. 2217-2225, 2010.

## Feedback

Please do not hesitate to contact us if there is anything we may be able to help you with.

mh.olyaee@gmail.com
