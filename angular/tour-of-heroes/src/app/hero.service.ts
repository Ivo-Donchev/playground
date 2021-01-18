import { Injectable } from '@angular/core';
import {Observable, of} from 'rxjs';
import { MessagesService } from './messages.service';
import { HEROES } from './mock-heroes';

@Injectable({
  providedIn: 'root'
})
export class HeroService {

  constructor(messagesService: MessagesService) {
    this.messagesService = messagesService;
  }
  
  getHeroes(): Observable<Hero[]> {
    this.messagesService.add('HeroService: fetched heroes.')
    return of(HEROES);
  }

}
