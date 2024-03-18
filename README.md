# Reproducer of issue with merging dwp files

run ``./build.sh`` and observe crash when verifying the "passthrough" dwp merge.

```
~/w/dwp_merge_repro main• ❱ ./build.sh
Verifying a.dwp:        file format elf64-x86-64
Verifying .debug_abbrev...
Verifying .debug_info Unit Header Chain...
Verifying .debug_types Unit Header Chain...
Verifying non-dwo Units...
Verifying dwo Units...
Verifying unit: 1 / 1, "src/a.cpp"
No errors.
Verifying main.dwp:     file format elf64-x86-64
Verifying .debug_abbrev...
Verifying .debug_info Unit Header Chain...
Verifying .debug_types Unit Header Chain...
Verifying non-dwo Units...
Verifying dwo Units...
Verifying unit: 1 / 1, "src/main.cpp"
No errors.
Verifying main_binary.dwp:      file format elf64-x86-64
Verifying .debug_abbrev...
Verifying .debug_info Unit Header Chain...
Verifying .debug_types Unit Header Chain...
Verifying non-dwo Units...
Verifying dwo Units...
Verifying unit: 1 / 2, "src/a.cpp"
Verifying unit: 2 / 2, "src/main.cpp"
No errors.
Verifying main_binary_that_crashes.dwp: file format elf64-x86-64
Verifying .debug_abbrev...
Verifying .debug_info Unit Header Chain...
Verifying .debug_types Unit Header Chain...
Verifying non-dwo Units...
Verifying dwo Units...
Verifying unit: 1 / 2, "src/a.cpp"
Verifying unit: 2 / 2error: invalid reference to or invalid content in .debug_str_offsets[.dwo]: length exceeds section size

error: DW_FORM_strx used without a valid string offsets table:

0x00000066: DW_TAG_compile_unit [1] *
              DW_AT_producer [DW_FORM_strx1]    (indexed (00000009) string = )
              DW_AT_language [DW_FORM_data2]    (DW_LANG_C_plus_plus_14)
              DW_AT_name [DW_FORM_strx1]        (indexed (0000000a) string = )
              DW_AT_dwo_name [DW_FORM_strx1]    (indexed (0000000b) string = )

error: DW_FORM_strx used without a valid string offsets table:

0x00000066: DW_TAG_compile_unit [1] *
              DW_AT_producer [DW_FORM_strx1]    (indexed (00000009) string = )
              DW_AT_language [DW_FORM_data2]    (DW_LANG_C_plus_plus_14)
              DW_AT_name [DW_FORM_strx1]        (indexed (0000000a) string = )
              DW_AT_dwo_name [DW_FORM_strx1]    (indexed (0000000b) string = )

error: DW_FORM_strx used without a valid string offsets table:

0x00000066: DW_TAG_compile_unit [1] *
              DW_AT_producer [DW_FORM_strx1]    (indexed (00000009) string = )
              DW_AT_language [DW_FORM_data2]    (DW_LANG_C_plus_plus_14)
              DW_AT_name [DW_FORM_strx1]        (indexed (0000000a) string = )
              DW_AT_dwo_name [DW_FORM_strx1]    (indexed (0000000b) string = )

error: DW_FORM_strx used without a valid string offsets table:

0x0000006c: DW_TAG_subprogram [2] * (0x00000066)
              DW_AT_low_pc [DW_FORM_addrx]      (indexed (00000000) address = <unresolved>)
              DW_AT_high_pc [DW_FORM_data4]     (0x0000000f)
              DW_AT_frame_base [DW_FORM_exprloc]        (DW_OP_reg7)
              DW_AT_call_all_calls [DW_FORM_flag_present]       (true)
              DW_AT_name [DW_FORM_strx1]        (indexed (00000000) string = )
              DW_AT_decl_file [DW_FORM_data1]   (0x00)
              DW_AT_decl_line [DW_FORM_data1]   (3)
              DW_AT_type [DW_FORM_ref4] (cu + 0x0047 => {0x00000099} "base ")
              DW_AT_external [DW_FORM_flag_present]     (true)

PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace.
Stack dump:
0.      Program arguments: llvm-dwarfdump-18 --verify main_binary_that_crashes.dwp
 #0 0x00007fe6aaeed7d6 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) (/usr/lib/llvm-18/bin/../lib/libLLVM.so.18.1+0xd937d6)
 #1 0x00007fe6aaeeb790 llvm::sys::RunSignalHandlers() (/usr/lib/llvm-18/bin/../lib/libLLVM.so.18.1+0xd91790)
 #2 0x00007fe6aaeede9b (/usr/lib/llvm-18/bin/../lib/libLLVM.so.18.1+0xd93e9b)
 #3 0x00007fe6a9d2e520 (/lib/x86_64-linux-gnu/libc.so.6+0x42520)
 #4 0x00007fe6ac889b7d llvm::DWARFUnit::getLoclistOffset(unsigned int) (/usr/lib/llvm-18/bin/../lib/libLLVM.so.18.1+0x272fb7d)
 #5 0x00007fe6ac874334 llvm::DWARFDie::getLocations(llvm::dwarf::Attribute) const (/usr/lib/llvm-18/bin/../lib/libLLVM.so.18.1+0x271a334)
 #6 0x00007fe6ac88c8a2 llvm::DWARFVerifier::verifyDebugInfoAttribute(llvm::DWARFDie const&, llvm::DWARFAttribute&) (/usr/lib/llvm-18/bin/../lib/libLLVM.so
.18.1+0x27328a2)
 #7 0x00007fe6ac88bddd llvm::DWARFVerifier::verifyUnitContents(llvm::DWARFUnit&, std::map<unsigned long, std::set<unsigned long, std::less<unsigned long>,
 std::allocator<unsigned long>>, std::less<unsigned long>, std::allocator<std::pair<unsigned long const, std::set<unsigned long, std::less<unsigned long>,
 std::allocator<unsigned long>>>>>&, std::map<unsigned long, std::set<unsigned long, std::less<unsigned long>, std::allocator<unsigned long>>, std::less<u
nsigned long>, std::allocator<std::pair<unsigned long const, std::set<unsigned long, std::less<unsigned long>, std::allocator<unsigned long>>>>>&) (/usr/l
ib/llvm-18/bin/../lib/libLLVM.so.18.1+0x2731ddd)
 #8 0x00007fe6ac88f771 llvm::DWARFVerifier::verifyUnits(llvm::DWARFUnitVector const&) (/usr/lib/llvm-18/bin/../lib/libLLVM.so.18.1+0x2735771)
 #9 0x00007fe6ac890c3c llvm::DWARFVerifier::handleDebugInfo() (/usr/lib/llvm-18/bin/../lib/libLLVM.so.18.1+0x2736c3c)
#10 0x00007fe6ac83ead8 llvm::DWARFContext::verify(llvm::raw_ostream&, llvm::DIDumpOptions) (/usr/lib/llvm-18/bin/../lib/libLLVM.so.18.1+0x26e4ad8)
#11 0x0000559f57971c27 (/usr/lib/llvm-18/bin/llvm-dwarfdump+0x17c27)
#12 0x0000559f57975377 (/usr/lib/llvm-18/bin/llvm-dwarfdump+0x1b377)
#13 0x0000559f57971a08 (/usr/lib/llvm-18/bin/llvm-dwarfdump+0x17a08)
#14 0x0000559f57971359 (/usr/lib/llvm-18/bin/llvm-dwarfdump+0x17359)
#15 0x00007fe6a9d15d90 __libc_start_call_main ./csu/../sysdeps/nptl/libc_start_call_main.h:58:16
#16 0x00007fe6a9d15e40 call_init ./csu/../csu/libc-start.c:128:20
#17 0x00007fe6a9d15e40 __libc_start_main ./csu/../csu/libc-start.c:379:5
#18 0x0000559f57964835 (/usr/lib/llvm-18/bin/llvm-dwarfdump+0xa835)
./build.sh: line 23: 471893 Segmentation fault      $DWARFDUMP --verify main_binary_that_crashes.dwp
```

