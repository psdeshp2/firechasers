#!/usr/bin/perl -w

use strict;
#use Image::OCR::Tesseract 'get_ocr';
use Spreadsheet::ParseExcel;
#use Image::Magick;
use WWW::Mechanize;
#use HTML::TableExtract;

my $parser   = Spreadsheet::ParseExcel->new();
my $workbook = $parser->Parse('/Users/parikshitdeshpande/Desktop/OnCampus/perlscriptforwebcraler/SmallBook.xls');
my @first_name;
my @second_name;
my $i = 0;
my $col;

my $mech = WWW::Mechanize->new();
#my $te = HTML::TableExtract->new;
#my $url = 'http://www.fs.fed.us/contactus/employee_search.shtml';
#$mech->get($url);
#$mech->follow_link( url => 'http://www.fs.fed.us/contactus/employee_search.shtml' );


for my $worksheet ( $workbook->worksheets() ) {
    my ( $row_min, $row_max ) = $worksheet->row_range();
    my ( $col_min, $col_max ) = $worksheet->col_range();
 
    for my $row ( 1 ..$row_max ) {
    	$col = 6;
        my $cell = $worksheet->get_cell( $row, $col );
        next unless $cell;
        #print "Row, Col    = ($row, $col)\n";
        #print "FirstName       = ", $cell->value(),       "\n";
	    $first_name[$i] = $cell->value();
        #print "Unformatted = ", $cell->unformatted(), "\n";
        #printf "\n";
        #print ${first_name}[$i];
        #print " ";
	    $col++;
        $cell = $worksheet->get_cell( $row, $col );
        next unless $cell;
        #print "Row, Col    = ($row, $col)\n";
        #print "SecondName      = ", $cell->value(),       "\n";
	    $second_name[$i] = $cell->value();
        #print "Unformatted = ", $cell->unformatted(), "\n";
        #print ${second_name}[$i];
    
        my $mech = WWW::Mechanize->new();
        my $url = 'http://www.fs.fed.us/contactus/employee_search.shtml';
        $mech->get($url);
        #$mech->follow_link( url => 'http://www.fs.fed.us/contactus/employee_search.shtml' );
        my $new_url= 'http://www.fs.fed.us/cgi-bin/Netdirsearch?firstname=' . ${first_name}[$i] . '&lastname=' . ${second_name}[$i] . '&office=all&nhits=50&submit=Search'  . "\n";
       # printf "I will navigate at ";
       # printf $new_url;
        $mech->get($new_url);
        printf $new_url;
      #  printf "Reached...";
    }
    $i++
}
