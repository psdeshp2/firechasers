  my $ultimateLink;
        my @links = $mech->links();
        for my $link ( @links ) {
#            printf "%s, %s\n" , $link->text , $link->url;            
            $mech->get($link->url);
 #           printf "\n" . $link->url;
            
            # Extract the value of Phone and Office fields
			
	   	 	my $c = $mech->content;
			$te->parse($c);
			my $data;
			my $ts;
			my $row;
			
			my $count = 0;
			foreach $ts ($te->tables) {
   				my $phone = substr($ts->cell(1,2),4);
   				my $address = substr($ts->cell(5,2),4);
   				print "\t";
   				print $phone;
   				print "\t";
   				print $address;
   			}
            
            	my $imageLink = $mech->find_image(url_regex => qr/email-images/i);
            
            	if ($imageLink){
            		printf "\nFound image extracting it.." ;
  #              	printf "\nImage link is " . $imageLink->url;
                	my $imageURL = $imageLink->url;
                	my $fileName = '/Users/parikshitdeshpande/Desktop/OnCampus/fireChasers/' . ${first_name}[$i] . '_' .  ${second_name}[$i] . '.gif';
                	$mech->get( $imageLink->url, ':content_file' => ${fileName});
            	} else{
                	printf "\n No image found\n";
            	}
            	