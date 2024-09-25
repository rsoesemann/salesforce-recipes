- [7 Ground Rules - As a Salesforce Developer, I will...](#ground-rules)
  - [Constantly learn and keep myself up-to-date](#constantly-learn-and-keep-myself-up-to-date)
  - [Write as few code as possible](#write-as-few-code-as-possible)
  - [Reach out for help, when stuck for too long](#reach-out-for-help-when-stuck-for-too-long)
  - [Leave code cleaner than I found it (Boy scout rule)](#leave-code-cleaner-than-i-found-it-boy-scout-rule)
  - [Grow a safety net of awesome tests](#grow-a-safety-net-of-awesome-tests)
  - [Let peers & tools constantly review my code](#let-peers--tools-constantly-review-my-code)
  - [Always care about non-functional aspects](#always-care-about-non-functional-aspects)

- [Guidelines](#guidelines)
  - [Code Style - Consistent is better than sophisticated](#code-style---consistent-is-better-than-sophisticated)
  - [Naming is important. And hard.](#naming-is-important-and-hard)
    - [Naming Examples](#naming-examples)
  - [Apex Classes and Triggers](#apex-classes-and-triggers)
  - [Apex Tests](#apex-tests)
  - [Salesforce Best Practices](#salesforce-best-practices)
  - [Deleting Managed Metadata is dangerous](#deleting-managed-metadata-is-dangerous)
  - 
# 7 Ground Rules - As a Salesforce Developer, I will...

## Constantly learn and keep myself up-to-date
- I read the Release Notes to know what happens on the Platform
- I constantly do Trailhead modules to extend existing knowledge and learn about new unrelated stuff (Blockchain, AI, Functions,...) 
- I use Twitter and the Trailblazer / Partner Communities to learn about new things outside of the regular releases (e.g. Dreamforce announcements). 
- I also learn about general development topics outside of Salesforce like DevOps, Agile, Clean Code, Cloud Technologies,..	
- Paper books are better sources of knowledge than blogs ;-).	
- By the end of next year I read [all the books from this list](https://www.amazon.de/ideas/amzn1.account.AEKQ3GPROZVZ6CDBZGBP47AWRQKQ/K1OLFFSNDB86?ref=idea_cp_vl_ov_d)
- I do those [Linkedin Leaning courses](https://www.linkedin.com/learning/instructors/m-scott-ford?u=91898849) 
## Write as few code as possible
- I leverage the Out Of the Box features of the Salesforce platform. 
- I learn and use Low Code, No Code and Declarative features e.g. Standard reporting vs. JS based diagramming, Base instead of custom UI components.
- I keep myself updated about Admin features using Trailhead and in the Release notes					
- I leverage proven AND licence-compatible Open-Source Libraries instead of using self-baked infrastructure code (trigger handling, HTTP, Security)
- I reach out to my architect to get approval for new libraries.
  
## Reach out for help, when stuck for too long
- Before I waste anybody's time, I do a thorough Google search.
- After that, I create a wonderful question (= short, precise, reproducible) on StackExchange.
- I pass the question link to my teammates that might be able to help in Chat(ter). 
- Sleep over it. Sometimes if you wait a day your brain will magically solve stuff for you.			
## Leave code cleaner than I found it (Boy scout rule) 
- I constantly do mini refactorings. 
- Before I add new stuff I clean up some mess. 
- I have collective code ownership. You see messy code from a teammate? Improve it. 
- I obey the Boy Scout rule: Always leave the code cleaner than you found it
							
## Grow a safety net of awesome tests
- I don't write alibi tests. 
- I invest in an awesome safety net of good tests. 
- I write good minimal tests with near 100% coverage
							
## Let peers & tools constantly review my code

- I do my best to write code where PMD, Reviewers, QA, and Salesforce Security Tean will not find any issue.
- I ask peers to pair-program with us if I are stuck or fear that I could over-engineer a solution	
- The person who asked for the review must respond to ALL comments. Either click LIKE (which means I will improve it as defined) or discuss using comments.
- Nobody should ask for a Review before he committed, checked the Quality Tool results, and fixed them in a second commit. If PMD reports false positives that need to be documented and discussed in the review. Only if I discuss it I can adjust/deactivate certain rules in Codacy.
- I never test somebody's code during a PR review. Here is why: https://www.yegor256.com/2019/12/03/testing-in-code-review.html
- Reviewers NEVER MERGE PRs. That is the job of the developer.

## Always care about non-functional aspects
- Only developers really understand and can properly design aspects like security, scalability and platform-specific limitations. As a Developer I constantly learn and grow my knowledge about Salesforce when it come to coping with Governor Limits, Security constrains, Coping with Large Data Volumes, Asynchronous Operations and the specific behaviour of metadata package and released as a Managed Package. Whenever I design or develop a feature I thing about how the thing I do can affect the security and performance of the system as well as the future flexibility.
  - [Security](https://developer.salesforce.com/docs/atlas.en-us.234.0.apexcode.meta/apexcode/apex_security_sharing_chapter.htm)
  - [Scalability & Volumes](https://www.apexhours.com/building-scalable-solutions-on-salesforce/)
  - [Consequences of changes (data model additions, deprecations)](https://developer.salesforce.com/docs/atlas.en-us.packagingGuide.meta/packagingGuide/packaging_component_behavior.htm)
  - [Readability, Maintainability, Testability, Extensibility of a solution](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882)


# Guidelines

## Code Style - Consistent is better than sophisticated
- Apex code and Flow names follows the [Google Code Conventions for Java](https://google.github.io/styleguide/javaguide.html)
- Function code should use their languages conventions
- Use Automatic Style using Prettier [(even if it sucks) or something less opinionated](https://salesforce.stackexchange.com/q/284806/256)
- Readability is more important than Consistency but Consistency is less subjective and easier to enforce. If you propose an improvement to readability thingk about objective proof and easy ways to enforce it.

## Naming is important. And hard.
- Naming is hard. And even more important. So spend time and effort into finding better names.
- Saying "I am bad with naming" is not an excuse. Then try harder to get better with it.
- Good Names reveal intentions and hide implementation details (Name should be stable, implementations change)
- The more important a name is the simpler it must be. CamelCaseHumps are a sign of overcomplicated naming
- Prefixing non-void methods with get... was needed in Java but is bad style in Apex. Having all methods start with g wont help readability. int age() and void age(int value) is much clearer.
- Examples:
  - `RegistrationQueue` is better than `PlatformEventHandler`
  - `age` is better than `intAge`
  - `students` is better than `studentList`
  - `Registration` is better than `IRegistrationDAOWrapper`
  - age() is better than getAge()
  - `explode()` is better than `triggerExplosionInitiation()`
  - `Result` is better than `ResultWrapper`
  - `Registration` is better than `RegistrationService` or `...Manager` 
  - Abbreviations like `RegistrationSvc` or `RegistrationMngr` are even worse. 
  
- Encourage reviewers to propose better names

### Naming Examples
- **Test:** Suffix with `Test` or `_Test` to make selecting tests easy and put tests next to their parent class.
- **Trigger:** Just the Object name as Plural. Dont' add the word "Trigger" as it is in the filename `.trigger` or the UI anyway.
- **Invocable:** Name it verb/command style and call the method `execute`: e.g. `RunApexTests.execute()`
- **VF/LWC Controller:** Indicate its a Controller (add easyly to permset) and who uses it `newContact.action` --> `NewContactActionCtrl` 
- **Custom Objects:** 
- **Custom Fields:** 

## Apex Classes and Triggers
- Test Classes are private, regular class public and you need a very good reason foir making it global. Put a // NOTE: on top to explain why.
- Except private classes are with sharing. If you leave it away or have different sharing put a // NOTE: on top to explain why
- As Apex IDEs don't do that for you (other than Java IDEs) structure your classes using // Constructor // Public // Private // Inner section comments
- Test classes just have an optional [// Helper]() section comment for private methods used by mutltiple tests
- A class should read like a good newpaper article, where the most important stuff comes at the beginning. Move implementation details to the end. And show the broad algorithm and actors on top. It's definitly not like a book where you need to read to the end to understand it.
- A method should do ONE thing and reveal that in its name. Complicated names with many CamelCaseHumps show that a method eighter does to much or you are describing the implementation instead.
- Methods that return something should alway in Line 1 declare it as `result` and return result in the last line. Always call it `result` it will dramatically increase readability. What it is, is decribed in the method name. 
- When you call your classes `Helper` or `Manager` you are doing something wrong. Read [here](https://www.yegor256.com/2015/03/09/objects-end-with-er.html) why.
- A Trigger never contain more than a single line of Code. It's the line delegating the work to a class. Triggers use the plural-form of the object they represent and never repeat the word `Trigger`.  So the file is `Students.trigger` and not `StudentTrigger.trigger` or such.
- No matter which trigger-framework (I recommend [this](https://github.com/mitchspano/apex-trigger-actions-framework) or [this](https://github.com/apex-enterprise-patterns/fflib-apex-common)) you use if there is a central Handler class just call it like the trigger `Students.cls`.
```````java
trigger Accounts on Account (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    fflib_SObjectDomain.triggerHandler(Accounts.class);
}
```````

## Apex Tests
- Good tests look like this 
  - Clear and concise Setup
  - One line Exercise
  - Simple assertions which reflect code and names
  - Fit on a single screen
  - Isolated, independant.

```````java
@IsTest
private class UpdateAccountStatus_Test {

    @IsTest
    private static void toRefreshedOnNewOpportunity() {

        // Setup
        Account account = (Account) new Account_t()
                            .name('Acme Corp')

                            .add( new Opportunity_t()
                                                .amount(1000)
                                                .closes(2019, 12))
        // Exercise
        .persist();


        // Verify
        System.assertEquals('Refreshed', account.BillingState);
    }
}
```````
- Keep tests short AND isolated. 
- Don't use shared variables, @TestSetup or static {} Blocks unless you have to. The make test more coupled which is a bad thing. Each test needs to obey the FIRST rules.
- Use the apex-domainbuilder library instead for Setup instead.
- Don't put the word "test" in the test method name
- No _ underscores to structure tests. Use separate test classes instead.
- Use Upper case @IsTest and not the outdated TestMethod modifier
- Test class name plus method name should sound a bit like a sentence: Calculator multiplies two integers
- Don't add words like works, correct, prove that. Everybody knows that this is what tests do.
- Don't use global variables for tests if you don't need it. It makes tests harder to understand and less independent
- Don't assert too much in a test. Better make two test methods
- Every test needs 3 comments to mark its // Setup, // Exercise and //Verify section
- Move stuff that is needed but somewhat irrelevant to tests to the bottom HELPER section
- A test class is a better documentation. Start with the general stuff and get more specific at the bottom. Don't add new test at the top but at the bottom.
- Only use Test.startTest Test.stopTest when you actually need to either run async code or reset limits. In such cases ALWAYS add a //Note: Explain why I need it
## Salesforce Best Practices
I know and apply all the [recommendations Salesforce has published](https://developer.salesforce.com/blogs/2022/01/drive-consistency-and-grow-developer-skills-with-a-developer-best-practices-checklist) for building secure apps that respect the limitations of the Platform
## Deleting Managed Metadata is dangerous

Deletion of a managed metadata requires detailed thinking and decision. Never decide to delete any metadata by yourself. Always check with a team member and a manager before taking any action. Even if we decide to delete any metadata from our package, send an email to all concerned parties to have a written information and also notification.
