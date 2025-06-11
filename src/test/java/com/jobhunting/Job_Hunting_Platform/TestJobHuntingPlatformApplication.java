package com.jobhunting.Job_Hunting_Platform;

import org.springframework.boot.SpringApplication;

public class TestJobHuntingPlatformApplication {

	public static void main(String[] args) {
		SpringApplication.from(JobHuntingPlatformApplication::main).with(TestcontainersConfiguration.class).run(args);
	}

}
