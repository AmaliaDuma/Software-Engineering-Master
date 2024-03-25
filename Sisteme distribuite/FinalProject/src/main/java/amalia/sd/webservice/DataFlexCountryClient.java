package amalia.sd.webservice;

import amalia.sd.webservice.dataflex.*;

import java.util.Scanner;
import java.util.stream.Collectors;

public class DataFlexCountryClient {

    public static void main(String[] args) {
        CountryInfoService service = new CountryInfoService();
        CountryInfoServiceSoapType port = service.getCountryInfoServiceSoap();


        boolean done = true;
        while (done) {
            printMenu();
            Scanner scanner = new Scanner(System.in);
            switch (scanner.nextInt()) {
                case 0: { done=false; break; }
                case 1: { continentsByName(port); break; }
                case 2: { continentsByCode(port); break; }
                case 3: { currenciesByName(port); break; }
                case 4: { currenciesByCode(port); break; }
                case 5: { findCurrencyByCode(port); break; }
                case 6: { countriesByName(port); break; }
                case 7: { countriesByCode(port); break; }
                case 8: { countriesByContinent(port); break; }
                case 9: { findCountryByCode(port); break; }
                case 10: { findCountryCodeByName(port); break; }
                case 11: { findCapitalForCountry(port); break; }
                case 12: { findCurrencyForCountry(port); break; }
                case 13: { findPhoneCodeForCountry(port); break; }
                case 14: { findAllCountryInfo(port); break; }
                case 15: { findAllCountriesForCurrency(port); break; }
                case 16: { languagesByName(port); break; }
                case 17: { languagesByCode(port); break; }
                case 18: { findLanguageByCode(port); break; }
                case 19: { findLanguageCodeByName(port); break; }
            }
        }
    }

    private static void printMenu() {
        String builder = "-----------------------------------\n" +
                "1. See all continents by name" + "\n" +
                "2. See all continents by code" + "\n" +
                "3. See all currencies by name" + "\n" +
                "4. See all currencies by code" + "\n" +
                "5. Find currency by code" + "\n" +
                "6. See all countries by name" + "\n" +
                "7. See all countries by code" + "\n" +
                "8. See all countries by continent" + "\n" +
                "9. Find country by code" + "\n" +
                "10. Find country code by name" + "\n" +
                "11. Find capital for country" + "\n" +
                "12. Find currency for country" + "\n" +
                "13. Find phone code for country" + "\n" +
                "14. Find all country info" + "\n" +
                "15. Find all countries for currency" + "\n" +
                "16. See all languages by name" + "\n" +
                "17. See all languages by code" + "\n" +
                "18. Find language by code" + "\n" +
                "19. Find language code by name" + "\n" +
                "0. Exit" + "\n" +
                "-----------------------------------";

        System.out.println(builder);
    }

    private static void continentsByName(CountryInfoServiceSoapType service) {
        service.listOfContinentsByName().getTContinent().forEach(tContinent -> {
            System.out.println(tContinent.getSCode() + " - " + tContinent.getSName());
        });
    }

    private static void continentsByCode(CountryInfoServiceSoapType service) {
        service.listOfContinentsByCode().getTContinent().forEach(tContinent -> {
            System.out.println(tContinent.getSCode() + " - " + tContinent.getSName());
        });
    }

    private static void currenciesByName(CountryInfoServiceSoapType service) {
        service.listOfCurrenciesByName().getTCurrency().forEach(tCurrency -> {
            System.out.println(tCurrency.getSISOCode() + " - " + tCurrency.getSName());
        });
    }

    private static void currenciesByCode(CountryInfoServiceSoapType service) {
        service.listOfCurrenciesByCode().getTCurrency().forEach(tCurrency -> {
            System.out.println(tCurrency.getSISOCode() + " - " + tCurrency.getSName());
        });
    }

    private static void findCurrencyByCode(CountryInfoServiceSoapType service) {
        System.out.println("Enter ISO code: ");
        Scanner scanner = new Scanner(System.in);
        String code = scanner.nextLine();
        System.out.println(service.currencyName(code));
    }

    private static void countriesByName(CountryInfoServiceSoapType service) {
        service.listOfCountryNamesByName().getTCountryCodeAndName().forEach(country -> {
            System.out.println(country.getSISOCode() + " - " + country.getSName());
        });
    }

    private static void countriesByCode(CountryInfoServiceSoapType service) {
        service.listOfCountryNamesByCode().getTCountryCodeAndName().forEach(country -> {
            System.out.println(country.getSISOCode() + " - " + country.getSName());
        });
    }

    private static void countriesByContinent(CountryInfoServiceSoapType service) {
        service.listOfCountryNamesGroupedByContinent().getTCountryCodeAndNameGroupedByContinent().forEach(continent -> {
            String builder = continent.getContinent().getSName() + ": " +
                    continent.getCountryCodeAndNames().getTCountryCodeAndName().stream()
                            .map(TCountryCodeAndName::getSName).collect(Collectors.joining(","));
            System.out.println(builder + "\n");
        });
    }

    private static void findCountryByCode(CountryInfoServiceSoapType service) {
        System.out.println("Enter ISO code: ");
        Scanner scanner = new Scanner(System.in);
        String code = scanner.nextLine();
        System.out.println(service.countryName(code));
    }

    private static void findCountryCodeByName(CountryInfoServiceSoapType service) {
        System.out.println("Enter country name: ");
        Scanner scanner = new Scanner(System.in);
        String name = scanner.nextLine();
        System.out.println(service.countryISOCode(name));
    }

    private static void findCapitalForCountry(CountryInfoServiceSoapType service) {
        System.out.println("Enter ISO code: ");
        Scanner scanner = new Scanner(System.in);
        String code = scanner.nextLine();
        System.out.println(service.capitalCity(code));
    }

    private static void findCurrencyForCountry(CountryInfoServiceSoapType service) {
        System.out.println("Enter ISO code: ");
        Scanner scanner = new Scanner(System.in);
        String code = scanner.nextLine();
        TCurrency currency = service.countryCurrency(code);
        System.out.println(currency.getSISOCode() + " - " + currency.getSName());
    }

    private static void findPhoneCodeForCountry(CountryInfoServiceSoapType service) {
        System.out.println("Enter ISO code: ");
        Scanner scanner = new Scanner(System.in);
        String code = scanner.nextLine();
        System.out.println(service.countryIntPhoneCode(code));
    }

    private static void findAllCountryInfo(CountryInfoServiceSoapType service) {
        System.out.println("Enter ISO code: ");
        Scanner scanner = new Scanner(System.in);
        String code = scanner.nextLine();
        TCountryInfo countryInfo = service.fullCountryInfo(code);

        String builder = "ISO code: " + countryInfo.getSISOCode() + "\n" +
                "Name: " + countryInfo.getSName() + "\n" +
                "Capital city: " + countryInfo.getSCapitalCity() + "\n" +
                "Phone code: " + countryInfo.getSPhoneCode() + "\n" +
                "Continent code: " + countryInfo.getSContinentCode() + "\n" +
                "Currency code: " + countryInfo.getSCurrencyISOCode() + "\n" +
                "Languages: " + countryInfo.getLanguages().getTLanguage().stream()
                .map(TLanguage::getSName).collect(Collectors.joining(","));
        System.out.println(builder);
    }

    private static void findAllCountriesForCurrency(CountryInfoServiceSoapType service) {
        System.out.println("Enter currency ISO code: ");
        Scanner scanner = new Scanner(System.in);
        String code = scanner.nextLine();
        System.out.println(service.countriesUsingCurrency(code).getTCountryCodeAndName().stream()
                .map(TCountryCodeAndName::getSName).collect(Collectors.joining(",")));
    }

    private static void languagesByName(CountryInfoServiceSoapType service) {
        service.listOfLanguagesByName().getTLanguage().forEach(tLanguage ->
                System.out.println(tLanguage.getSISOCode() + " - " + tLanguage.getSName()));
    }

    private static void languagesByCode(CountryInfoServiceSoapType service) {
        service.listOfLanguagesByCode().getTLanguage().forEach(tLanguage ->
                System.out.println(tLanguage.getSISOCode() + " - " + tLanguage.getSName()));
    }

    private static void findLanguageByCode(CountryInfoServiceSoapType service) {
        System.out.println("Enter ISO code: ");
        Scanner scanner = new Scanner(System.in);
        String code = scanner.nextLine();
        System.out.println(service.languageName(code));
    }

    private static void findLanguageCodeByName(CountryInfoServiceSoapType service) {
        System.out.println("Enter language name: ");
        Scanner scanner = new Scanner(System.in);
        String name = scanner.nextLine();
        System.out.println(service.languageISOCode(name));
    }
}
