//Librairies permettant de communiquer avec tweeter
import twitter4j.util.*;
import twitter4j.*;
import twitter4j.management.*;
import twitter4j.api.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.auth.*;

import processing.serial.* ;// bibliotheque permettant de gérer les communications série USB
Serial port_arduino; // création de l'objet connexion série
int index_port=0; // numéro de port a modifier en fonction de l'ordi et du resultat de " println(Serial.list()); "
int vitesse = 9600; // vitesse de la communication série en bauds
String trame=""; // trame reçue avant saucissonage
int LF=10; // valeur du retour chariot en ASCII
Twitter twitter ; // declaration de l'objet tweeter

void setup() {
  //variables d'affichages
  size(400, 300);
  background(0); // couleur du fond d'ecran
  textSize(11); // taille du texte
  textLeading(11); //taille des interlignes du texte
 // initialisation de la connexion USB
 
    port_arduino=new Serial(this, Serial.list()[index_port], vitesse); 
      
  // CREDENTIALS
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey ("XXXXXXXXXXXXXXXXx");
  cb.setOAuthConsumerSecret("XXXXXXXXXXXXXXXXXXXXX");
  cb.setOAuthAccessToken("XXXXXXXXXXXXXXXXXX");
  cb.setOAuthAccessTokenSecret("XXXXXXXXXXXXXXXXXXXXXXXXX");
  TwitterFactory tf = new TwitterFactory(cb.build());

  twitter = tf.getInstance(); // demarrage de l'instance tweeter
}

void draw() {
}


void tweet(String message) // fonction qui change le statut tweeter
{
  try 
  {
    Status status = twitter.updateStatus(message);
    System.out.println("Status updated to [" + status.getText() + "].");
  }
  catch (TwitterException te)
  {
    System.out.println("Error: "+ te.getMessage());
  }
}

void keyPressed()
{
  tweet("ça tweet ! ");
}



void serialEvent(Serial p) { 

  if (port_arduino.available()>0) { // si on reçoit qqchose sur le port série
    trame=port_arduino.readStringUntil(LF); //récupere la chaine de caractere jusqu'au retour chariot de println)
  }

  if (trame!=null) { // vérifie que l'on ne reçois pas n'importe quoi, enfin quelquechose

    // on envoie la trame reçue a tweeter !
    
    tweet(trame);
  }
}

