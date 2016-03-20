" Vim syntax file
" Language:    ROOT Data Analysis Framework (C++)
" Maintainer:  Matthew Parnell <matt@parnmatt.co.uk>
"              Oliver Lantwin  <oliver@lantwin.de>
" Version:     1.0.0
" Last Change: 2014-07-28
" Remark:      To be used with filetype cpp
" Remark:      Place file:  $VIMRUNTIME/syntax/root.vim
" Remark:      ROOT website: http://root.cern.ch/

if v:version < 600
    finish
elseif exists("b:current_syntax")

    " Is language C++
    if b:current_syntax ==? "c" || b:current_syntax ==? "cpp"

        " Ensure C++ syntax is loaded, rather than C
        setfiletype cpp

        let b:cpp = 1

    elseif b:current_syntax ==? "python"
        let b:cpp = 0
    else
        finish
    endif
endif

" Grouped as they are in http://root.cern.ch/root/html/Rtypes.h
" Not needed in PyROOT
if !empty(b:cpp)

    " Primitive Typedefs
    syntax keyword rootTypedef
        \ Char_t UChar_t
        \ Short_t UShort_t
        \ Int_t UInt_t
        \ Seek_t Long_t ULong_t
        \ Float_t Float16_t
        \ Double_t Double32_t
        \ LongDouble_t Text_t Bool_t Byte_t Version_t Option_t Ssiz_t
        \ Real_t
        \ Long64_t ULong64_t
        \ Axis_t Stat_t
        \ Font_t Style_t Marker_t Width_t Color_t SCoord_t Coord_t Angle_t
        \ Size_t
endif

" Colour Enums
syntax keyword rootEnums
    \ kWhite kBlack kGray kRed kGreen kBlue kYellow kMagenta kCyan
    \ kOrange kSpring kTeal kAzure kViolet kPink

" Booleans
syntax keyword rootBoolean
    \ kTRUE kFALSE

" Type constants
syntax keyword rootConstant
    \ kMaxUChar kMaxChar kMinChar
    \ kMaxUShort kMaxShort kMinShort
    \ kMaxUInt kMaxInt kMinInt
    \ kMaxULong kMaxLong kMinLong
    \ kMaxULong64 kMaxLong64 kMinLong64
    \ kBitsPerByte kNPOS

" ROOT Global Variables
syntax keyword rootGlobalVariables
    \ gApplication gClassTable gDebug gDirectory gEnv gFile gObjectTable
    \ gPad gProgName gProgPath gROOT gRandom gRootDir gStyle gSystem

" ROOT Classes (Common)
" Top-level Classes
syntax keyword rootClass
    \ TObject TClass TROOT
    \ TCollection TList TClonesArray TObjArray TNtuple

" Filesystem and datastructures
syntax keyword rootClass
    \ TDirectory TFile TBrowser
    \ TTree TChain TBranch TLeaf

" Text and Strings
syntax keyword rootClass
    \ TString TText TLatex

" Histograms
syntax keyword rootClass
    \ TH1 TH1C TH1S TH1I TH1F TH1D
    \ TH2 TH2C TH2S TH2I TH2F TH2D
    \ TH3 TH3C TH3S TH3I TH3F TH3D
    \ THStack

" Functions and Fits
syntax keyword rootClass
    \ TFormula
    \ TF1 TF12 TF2 TF3
    \ TFitResult TFitResultPtr

" Graphics
syntax keyword rootClass
    \ TCanvas TLegend
    \ TGraph TGraphErrors TGraph2D TGraph2DErrors
    \ TAxis
    \ THtml TPDF TSVG TPostScript

" Mathematics
syntax keyword rootClass
    \ TMath
" Physics Vector package
syntax keyword rootClass
    \ TVector2 TVector3 TRotation TLorentzVector TLorentzRotation

highlight default link rootBoolean Boolean
highlight default link rootClass Type
highlight default link rootConstant Constant
highlight default link rootEnums Constant
highlight default link rootGlobalVariables SpecialChar
highlight default link rootTypedef Typedef

if empty(b:cpp)
    let b:current_syntax = "PyROOT"
else
    let b:current_syntax = "C++/ROOT"
endif

unlet b:cpp
