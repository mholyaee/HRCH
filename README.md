# HRCH
This code is related to our recently proposed method called HRCH. This method can solve single individual haplotype problem for the both diploid and polyploid organisms
# Requirement:
This program is suitable for MATLAB R2013a and above versions. The program has adopted by Geraci's dataset. By some little change it can be used for any input data.

# Running the method
Please call the functions with this order:
1) HGHapCut_mec_RAX
2) newConfidRahman
3) callFillGapsDiploid

# The first function can be called in two forms:

1) Without any input arguments

In this form, The function will be executed on the Geraci's dataset as defualt. In addition, the obtained results including the reconstruction rate(RR),running time and the output haplotypes will be saved in some text files on the current path.

2) Call with input arguments

In this case, the user can run the program for a specified matrix fragments. The call function template is as follow:

HGHapCut_mec_RAX('Sim0','TargetHaps')

Which 'Sim0' is a filename contaning the matrix fragment and 'TargetHaps' is a file which involves the target haplotypes.
It should be noted that their formats must be comaptible with Geraci's benchmark (Please see Sim0 and TargetHaps files).

The details of used dataset can be accessible in the below paper:

F. Geraci, "A comparison of several algorithms for the single individual SNP haplotyping reconstruction problem," Bioinformatics, vol. 26, pp. 2217-2225, 2010.

Feedback
Please do not hesitate to contact us if there is anything we may be able to help you with.
mh.olyaee@gmail.com
